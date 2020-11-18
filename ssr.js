const fs = require('fs');
const { URLSearchParams } = require('url');
const data = fs.readFileSync('/dev/stdin', 'utf8');
// const data = fs.readFileSync('sub.txt', 'utf8');

const atob = str => str ? Buffer.from(str, 'base64').toString('utf8') : "";

const parseSSR = (str) => {
  const [server, server_port, protocol, method, obfs, password, params] = str.split(/:|\//);
  const urlParam = new URLSearchParams(params);
  const obfs_param = atob(urlParam.get('obfsparam'));
  const protocol_param = atob(urlParam.get('protoparam'));
  const remarks = atob(urlParam.get('remarks'));
  const group = atob(urlParam.get('group'));
  return {
    server,
    server_ipv6: '::',
    server_port,
    local_address: '127.0.0.1',
    local_port: 1080,
    
    password: atob(password),
    method,
    protocol,
    protocol_param,
    obfs,
    obfs_param,
    speed_limit_per_con: 0,
    speed_limit_per_user: 0,

    additional_ports : {}, // only works under multi-user mode
    additional_ports_only : false, // only works under multi-user mode
    timeout: 120,
    udp_timeout: 60,
    dns_ipv6: false,
    connect_verbose_info: 0,
    redirect: '',
    fast_open: false,

    remarks,
    group,
  };
}

let count = 0;
atob(data).trim().split('\n').map((ssrlink) => {
  const config = parseSSR(atob(ssrlink.slice(6)));
  ++ count;
  fs.writeFileSync(`shadowsocksr/config.${count}.json`, JSON.stringify(config, null, 2));
  console.log(`[${count}] ${config.group}::${config.remarks}`);
});
