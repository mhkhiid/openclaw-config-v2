module.exports = {
  apps: [{
    name: 'openclaw-gateway',
    script: 'openclaw.mjs',
    args: 'gateway run',
    cwd: '/Users/hengdeding/.nvm/versions/node/v24.13.0/lib/node_modules/openclaw',

    // 自动重启配置
    autorestart: true,
    max_restarts: 10,
    min_uptime: '10s',

    // 关键：启动前先运行 doctor --fix
    pre_exec: 'openclaw doctor --fix',

    // 日志配置
    log_file: '/Users/hengdeding/.openclaw/logs/pm2-openclaw.log',
    log_date_format: 'YYYY-MM-DD HH:mm:ss Z',

    // 环境变量
    env: {
      NODE_ENV: 'production'
    },

    // 错误时等待 5 秒再重启（避免太频繁）
    exp_backoff_restart_delay: 5000
  }]
};
