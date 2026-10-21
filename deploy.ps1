# 一键构建并部署博客到 GitHub Pages（gh-pages 分支）
# 用法：先设置环境变量 GITHUB_TOKEN（GitHub Personal Access Token，需 repo 权限），再运行 ./deploy.ps1
# 国内网络直连 GitHub 失败时，可先为本机 git 配置代理（如 Clash），例如：
#   git config --global http.proxy http://127.0.0.1:7890
#   git config --global https.proxy http://127.0.0.1:7890
param(
    [string]$Owner = "HortonWen",
    [string]$RepoName = "solaris-blog-rm-seu-cxxy",
    [string]$WorkBranch = "main"
)

$ErrorActionPreference = "Stop"

if (-not $env:GITHUB_TOKEN) {
    Write-Host "错误：未检测到 GITHUB_TOKEN 环境变量。" -ForegroundColor Red
    Write-Host "请先执行：`$env:GITHUB_TOKEN = '你的token' （或通过系统环境变量设置）" -ForegroundColor Yellow
    exit 1
}

$root = Split-Path -Parent $MyInvocation.MyCommand.Path
Set-Location -LiteralPath $root

# 1. 构建
Write-Host "==> 构建中（pnpm build）..."
pnpm build
if ($LASTEXITCODE -ne 0) { Write-Host "构建失败。" -ForegroundColor Red; exit 1 }

# 2. 同步 dist 到 gh-pages 分支
$repoUrl = "https://x-access-token:$env:GITHUB_TOKEN@github.com/$Owner/$RepoName.git"
$tmp = Join-Path $env:TEMP ("gh-pages-" + [guid]::NewGuid().ToString("N"))

Write-Host "==> 同步构建产物到 gh-pages 分支..."
git clone --depth 1 --branch gh-pages $repoUrl $tmp 2>$null
if ($LASTEXITCODE -ne 0) {
    # 分支尚不存在：创建空分支
    New-Item -ItemType Directory -Force -Path $tmp | Out-Null
    git -C $tmp init
    git -C $tmp checkout --orphan gh-pages 2>$null
}
git -C $tmp rm -rf --quiet --ignore-unmatch .
Copy-Item -Path (Join-Path $root "dist\*") -Destination $tmp -Recurse -Force
git -C $tmp add -A
git -C $tmp -c user.name="Solaris Bot" -c user.email="solaris-bot@users.noreply.github.com" commit --quiet -m "deploy: update site build $(Get-Date -Format 'yyyy-MM-dd HH:mm')"
git -C $tmp push $repoUrl gh-pages --force
if ($LASTEXITCODE -ne 0) { Write-Host "推送失败。" -ForegroundColor Red; exit 1 }

Remove-Item -LiteralPath $tmp -Recurse -Force
Write-Host "部署完成：https://$($Owner.ToLower()).github.io/$RepoName/" -ForegroundColor Green
