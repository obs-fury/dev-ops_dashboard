<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>CloudFlow - Cloud Infrastructure Overview</title>
<style>
  :root{
    --bg:#eef0f7; --card:#ffffff; --ink:#15182b; --muted:#6b7089; --line:#e8eaf3;
    --purple:#5b4bc4; --purple-soft:#efecfd; --green:#1f9d55; --amber:#e3a008; --red:#d64545;
    --side:#161a2b; --side-ink:#c9cde0;
  }
  *{box-sizing:border-box;margin:0;padding:0}
  body{font-family:Inter,"Segoe UI",system-ui,-apple-system,Roboto,Arial,sans-serif;background:linear-gradient(160deg,#f6f7fc,#e9e8f7);color:var(--ink);min-height:100vh;padding:28px;font-size:13px}
  .app{display:flex;max-width:1280px;margin:0 auto;background:#f2f4f9;border-radius:22px;overflow:hidden;box-shadow:0 18px 60px rgba(40,40,90,.18);border:6px solid #fff}

  /* Sidebar */
  .sidebar{width:230px;background:var(--side);color:var(--side-ink);padding:20px 14px;flex-shrink:0;display:flex;flex-direction:column;gap:14px}
  .brand{display:flex;align-items:center;gap:8px;color:#fff;font-weight:700;font-size:17px;padding:0 6px}
  .brand svg{width:26px;height:26px;stroke:#8f84f0}
  .user{display:flex;align-items:center;gap:10px;padding:6px;color:#fff;font-weight:600}
  .avatar{width:28px;height:28px;border-radius:50%;background:linear-gradient(135deg,#f6c58b,#c9855a);display:grid;place-items:center;font-size:12px;color:#3b2412;font-weight:700}
  .user .chev{margin-left:auto;opacity:.6}
  .search{display:flex;align-items:center;gap:8px;background:#222741;border:1px solid #2d3355;border-radius:8px;padding:8px 10px}
  .search input{background:none;border:0;outline:0;color:#fff;width:100%;font-size:13px}
  .search input::placeholder{color:#8a90ad}
  .nav{display:flex;flex-direction:column;gap:2px;margin-top:4px}
  .nav a{display:flex;align-items:center;gap:12px;padding:10px 12px;border-radius:8px;color:var(--side-ink);text-decoration:none;cursor:pointer;font-weight:500;transition:.15s}
  .nav a:hover{background:#20253f;color:#fff}
  .nav a.active{background:#272d4b;color:#fff}
  .nav svg{width:16px;height:16px;stroke:currentColor;fill:none;stroke-width:1.8;stroke-linecap:round;stroke-linejoin:round}

  /* Main */
  .main{flex:1;padding:22px 22px 26px;min-width:0}
  .topbar{display:flex;align-items:center;justify-content:space-between;margin-bottom:16px}
  .topbar h1{font-size:22px;font-weight:700;letter-spacing:-.3px}
  .actions{display:flex;gap:8px}
  .icon-btn{width:34px;height:34px;border-radius:9px;border:1px solid var(--line);background:#fff;display:grid;place-items:center;cursor:pointer}
  .icon-btn svg{width:16px;height:16px;stroke:#444;fill:none;stroke-width:1.8}
  .btn-primary{background:var(--purple);color:#fff;border:0;border-radius:9px;padding:0 14px;height:34px;font-weight:600;cursor:pointer;font-size:13px;display:flex;align-items:center;gap:6px}
  .btn-primary:hover{background:#4a3cb0}

  .card{background:var(--card);border:1px solid var(--line);border-radius:12px;padding:16px;box-shadow:0 1px 2px rgba(20,20,60,.04)}
  .card h2{font-size:15px;font-weight:700;margin-bottom:2px}
  .card .sub{color:var(--muted);font-size:11.5px;margin-bottom:10px}
  .card-head{display:flex;align-items:flex-start;justify-content:space-between;gap:8px}

  .stats{display:grid;grid-template-columns:repeat(4,1fr);margin-bottom:16px;padding:14px 8px}
  .stat{text-align:center;border-right:1px solid var(--line);padding:2px 8px;font-weight:500}
  .stat:last-child{border-right:0}
  .stat b{font-weight:700}
  .c-purple{color:var(--purple)} .c-green{color:var(--green)} .c-red{color:var(--red)} .c-amber{color:var(--amber)}

  .grid2{display:grid;grid-template-columns:1fr 1fr;gap:16px;margin-bottom:16px}

  select,.seg{font-family:inherit;font-size:12px}
  select{border:1px solid var(--line);background:#fff;border-radius:8px;padding:6px 8px;color:var(--ink);cursor:pointer;outline:0}
  .seg{display:flex;border:1px solid var(--line);border-radius:8px;overflow:hidden}
  .seg button{border:0;background:#fff;padding:6px 9px;cursor:pointer;font-size:12px;color:var(--muted);font-family:inherit}
  .seg button.on{background:var(--purple);color:#fff}

  /* chart */
  .chart-wrap{position:relative;height:150px;margin:2px 0 8px}
  canvas{width:100%;height:100%;display:block}
  table{width:100%;border-collapse:collapse}
  th{text-align:left;font-size:11.5px;color:var(--muted);font-weight:600;padding:6px 4px;border-bottom:1px solid var(--line)}
  td{padding:9px 4px;border-bottom:1px solid var(--line);font-size:12.5px}
  tr:last-child td{border-bottom:0}
  .dot{display:inline-block;width:8px;height:8px;border-radius:50%;margin-right:7px}
  .d-green{background:var(--green)} .d-amber{background:var(--amber)} .d-gray{background:#9aa0b5} .d-red{background:var(--red)}
  .st-active{color:var(--green);font-weight:500} .st-warn{color:var(--amber);font-weight:500}

  /* k8s */
  .k8s{display:grid;grid-template-columns:repeat(3,1fr);gap:10px}
  .cl{border:1px solid var(--line);border-radius:10px;padding:10px;cursor:pointer;transition:.15s;background:#fff}
  .cl:hover{border-color:#c9c3f3;transform:translateY(-1px)}
  .cl.sel{background:var(--purple-soft);border-color:var(--purple)}
  .cl .nm{display:flex;justify-content:space-between;font-weight:700;font-size:12.5px;margin-bottom:6px}
  .cl .tick{color:var(--purple)}
  .cl .lbl{font-size:11px;color:var(--muted);margin:5px 0 3px}
  .dots i{display:inline-block;width:9px;height:9px;border-radius:50%;margin-right:5px}
  .pods{display:flex;justify-content:space-between;font-size:11px;font-weight:600;color:var(--green)}
  .gauges{display:flex;gap:10px;justify-content:space-between;margin-top:4px}
  .g{text-align:center;font-size:10.5px;font-weight:600;flex:1}
  .g svg{width:44px;height:44px;display:block;margin:0 auto 2px}

  /* pipeline */
  .pipe{display:flex;align-items:center;justify-content:space-between;margin:12px 0 14px;padding:0 4px}
  .stage{text-align:center;font-size:12px;font-weight:600;min-width:52px}
  .stage small{display:block;color:var(--muted);font-weight:500;font-size:11px}
  .node{width:36px;height:36px;border-radius:50%;margin:0 auto 5px;display:grid;place-items:center;border:2px solid #cfd3e3;background:#fff}
  .node svg{width:16px;height:16px;fill:none;stroke-width:2;stroke-linecap:round;stroke-linejoin:round}
  .node.done{border-color:#7cc99c;background:#e8f7ee} .node.done svg{stroke:var(--green)}
  .node.run{border-color:var(--purple);background:var(--purple-soft)} .node.run svg{stroke:var(--purple)}
  .node.run{animation:pulse 1.4s infinite}
  @keyframes pulse{0%{box-shadow:0 0 0 0 rgba(91,75,196,.4)}70%{box-shadow:0 0 0 9px rgba(91,75,196,0)}100%{box-shadow:0 0 0 0 rgba(91,75,196,0)}}
  .arrow{color:#aab0c6;font-size:14px;margin-top:-18px}
  .st-ok{color:var(--green);font-weight:500}
  .st-fail{color:var(--red);font-weight:500}
  .st-run{color:var(--purple);font-weight:500}
  td.r,th.r{text-align:right}

  /* console */
  .console{background:#0f1320;border-radius:10px;padding:14px;height:230px;overflow-y:auto;font-family:"JetBrains Mono",Consolas,Menlo,monospace;font-size:12px;line-height:1.75;color:#cbd2ea;position:relative}
  .console .ln{white-space:nowrap}
  .console .t{color:#7e86a6;margin-right:8px}
  .lv-INFO{color:#46c07b} .lv-WARN{color:#f0b429} .lv-SUCCESS{color:#4ade80;font-weight:700} .lv-ERROR{color:#ff6b6b}
  .copy{position:absolute;top:8px;right:8px;background:#1b2036;border:1px solid #2c3354;color:#aeb6d6;border-radius:6px;padding:3px 7px;cursor:pointer;font-size:11px}
  .console-box{position:relative}
  .copy{z-index:2}

  /* uptime */
  .uptime{display:grid;grid-template-columns:repeat(4,1fr);gap:12px;margin-top:6px}
  .up{background:#f6f8f7;border:1px solid var(--line);border-radius:8px;padding:8px 10px 0;overflow:hidden}
  .up .row{display:flex;justify-content:space-between;font-size:12.5px;font-weight:500;padding-bottom:7px}
  .up .row span:first-child:before{content:"";display:inline-block;width:8px;height:8px;border-radius:50%;background:var(--green);margin-right:7px}
  .up .bar{height:4px;background:var(--green);margin:0 -10px}

  .more{color:#888;cursor:pointer;letter-spacing:2px;font-weight:700;user-select:none}

  @media (max-width:1050px){
    .grid2{grid-template-columns:1fr}
    .uptime{grid-template-columns:1fr 1fr}
  }
  @media (max-width:760px){
    body{padding:10px}
    .app{flex-direction:column}
    .sidebar{width:100%}
    .nav{flex-direction:row;flex-wrap:wrap}
    .stats{grid-template-columns:1fr 1fr;row-gap:10px}
    .k8s{grid-template-columns:1fr 1fr}
    .uptime{grid-template-columns:1fr}
  }
</style>
</head>
<body>
<div class="app">

  <!-- Sidebar -->
  <aside class="sidebar">
    <div class="brand">
      <svg viewBox="0 0 24 24" fill="none" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M17.5 19a4.5 4.5 0 1 0-1.4-8.77A6 6 0 0 0 4.5 12.5 3.5 3.5 0 0 0 6 19z"/></svg>
      CloudFlow
    </div>
    <div class="user">
      <div class="avatar">A</div> Alex R.
      <svg class="chev" width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="m6 9 6 6 6-6"/></svg>
    </div>
    <div class="search">
      <svg width="15" height="15" viewBox="0 0 24 24" fill="none" stroke="#8a90ad" stroke-width="2"><circle cx="11" cy="11" r="7"/><path d="m21 21-4.3-4.3"/></svg>
      <input type="text" placeholder="Search" id="navSearch">
    </div>
    <nav class="nav" id="nav">
      <a class="active"><svg viewBox="0 0 24 24"><rect x="3" y="3" width="7" height="7" rx="1"/><rect x="14" y="3" width="7" height="7" rx="1"/><rect x="3" y="14" width="7" height="7" rx="1"/><rect x="14" y="14" width="7" height="7" rx="1"/></svg>Dashboard</a>
      <a><svg viewBox="0 0 24 24"><path d="M12 2 2 7l10 5 10-5z"/><path d="m2 17 10 5 10-5"/><path d="m2 12 10 5 10-5"/></svg>Infrastructure</a>
      <a><svg viewBox="0 0 24 24"><path d="M12 2 3 7v10l9 5 9-5V7z"/><circle cx="12" cy="12" r="3"/></svg>Kubernetes</a>
      <a><svg viewBox="0 0 24 24"><circle cx="6" cy="5" r="2"/><circle cx="6" cy="19" r="2"/><circle cx="18" cy="9" r="2"/><path d="M6 7v10M18 11c0 4-6 3-12 6"/></svg>Pipelines</a>
      <a><svg viewBox="0 0 24 24"><path d="M4 6h16M4 12h10M4 18h14"/></svg>Logs</a>
      <a><svg viewBox="0 0 24 24"><rect x="3" y="4" width="18" height="14" rx="2"/><path d="M7 14l3-3 3 2 4-5"/></svg>Monitoring</a>
      <a><svg viewBox="0 0 24 24"><circle cx="12" cy="12" r="3"/><path d="M19.4 15a1.7 1.7 0 0 0 .3 1.8l.1.1a2 2 0 1 1-2.8 2.8l-.1-.1a1.7 1.7 0 0 0-1.8-.3 1.7 1.7 0 0 0-1 1.5V21a2 2 0 1 1-4 0v-.1a1.7 1.7 0 0 0-1.1-1.5 1.7 1.7 0 0 0-1.8.3l-.1.1a2 2 0 1 1-2.8-2.8l.1-.1a1.7 1.7 0 0 0 .3-1.8 1.7 1.7 0 0 0-1.5-1H3a2 2 0 1 1 0-4h.1a1.7 1.7 0 0 0 1.5-1.1 1.7 1.7 0 0 0-.3-1.8l-.1-.1a2 2 0 1 1 2.8-2.8l.1.1a1.7 1.7 0 0 0 1.8.3H9a1.7 1.7 0 0 0 1-1.5V3a2 2 0 1 1 4 0v.1a1.7 1.7 0 0 0 1 1.5 1.7 1.7 0 0 0 1.8-.3l.1-.1a2 2 0 1 1 2.8 2.8l-.1.1a1.7 1.7 0 0 0-.3 1.8V9a1.7 1.7 0 0 0 1.5 1H21a2 2 0 1 1 0 4h-.1a1.7 1.7 0 0 0-1.5 1z"/></svg>Settings</a>
    </nav>
  </aside>

  <!-- Main -->
  <main class="main">
    <div class="topbar">
      <h1>Cloud Infrastructure Overview</h1>
      <div class="actions">
        <button class="icon-btn" title="Settings"><svg viewBox="0 0 24 24"><circle cx="12" cy="12" r="3"/><path d="M12 2v3M12 19v3M2 12h3M19 12h3M4.9 4.9 7 7M17 17l2.1 2.1M4.9 19.1 7 17M17 7l2.1-2.1"/></svg></button>
        <button class="btn-primary" id="refreshBtn">&#10042; Dashboard</button>
      </div>
    </div>

    <!-- Summary -->
    <div class="card stats">
      <div class="stat">Active Servers: <b class="c-purple" id="sServers">48 &#8593;</b></div>
      <div class="stat">K8s Clusters: <b id="sClusters">6</b></div>
      <div class="stat">Deployment Status: <b class="c-green" id="sDeploy">Healthy</b></div>
      <div class="stat">Active Alerts: <b class="c-red" id="sAlerts">3</b></div>
    </div>

    <div class="grid2">
      <!-- Server monitoring -->
      <section class="card">
        <div class="card-head">
          <div>
            <h2>Server Monitoring</h2>
            <div class="sub">Real-time graph of CPU, Memory, Network Usage</div>
          </div>
          <div class="seg" id="metricSeg">
            <button data-m="all" class="on">CPU/Mem</button>
            <button data-m="net">Network</button>
          </div>
        </div>
        <div class="chart-wrap"><canvas id="chart"></canvas></div>
        <table>
          <thead><tr><th>Server</th><th>Status</th><th>CPU%</th><th>RAM</th><th>Disk</th></tr></thead>
          <tbody id="serverBody"></tbody>
        </table>
      </section>

      <!-- Kubernetes -->
      <section class="card">
        <div class="card-head">
          <h2>Kubernetes Cluster Status</h2>
          <select id="clFilter">
            <option value="all">Clusters</option>
            <option value="prod">Production</option>
            <option value="nonprod">Non-prod</option>
          </select>
        </div>
        <div class="k8s" id="k8s" style="margin-top:10px"></div>
      </section>
    </div>

    <div class="grid2">
      <!-- Pipeline -->
      <section class="card">
        <div class="card-head"><h2>CI/CD Pipeline Visualization</h2><span class="more">&middot;&middot;&middot;</span></div>
        <div class="card-head" style="align-items:center">
          <div class="sub" style="margin:0">Active pipelines<br>Project: <span id="projName">WebApp v2.1</span></div>
          <select id="projSel">
            <option>WebApp v2.1</option>
            <option>project-web</option>
            <option>frontend-v2.1</option>
          </select>
        </div>
        <div class="pipe" id="pipe"></div>
        <table>
          <thead><tr><th>Recent builds</th><th>Status</th><th class="r">Duration</th></tr></thead>
          <tbody id="builds"></tbody>
        </table>
      </section>

      <!-- Logs -->
      <section class="card">
        <div class="card-head"><h2>Deployment Logs</h2><span class="more">&middot;&middot;&middot;</span></div>
        <div class="card-head" style="align-items:center;margin-bottom:10px">
          <div class="sub" style="margin:0">Console output for last deployment</div>
          <select id="logSel">
            <option>frontend-v2.1</option>
            <option>WebApp v2.1</option>
            <option>project-web</option>
          </select>
        </div>
        <div class="console-box">
          <button class="copy" id="copyBtn">Copy</button>
          <div class="console" id="console"></div>
        </div>
      </section>
    </div>

    <!-- Uptime -->
    <section class="card">
      <div class="card-head"><h2>Uptime Metrics</h2><span class="more">&middot;&middot;&middot;</span></div>
      <div class="uptime" id="uptime"></div>
    </section>
  </main>
</div>

<script>
(function(){
  "use strict";
  function $(id){return document.getElementById(id);}
  function rnd(a,b){return Math.round(a+Math.random()*(b-a));}
  function pad(n){return (n<10?"0":"")+n;}
  function clock(){var d=new Date();return pad(d.getHours())+":"+pad(d.getMinutes())+":"+pad(d.getSeconds());}

  /* ---------- Sidebar ---------- */
  var links=document.querySelectorAll("#nav a");
  Array.prototype.forEach.call(links,function(a){
    a.addEventListener("click",function(){
      Array.prototype.forEach.call(links,function(x){x.classList.remove("active");});
      a.classList.add("active");
    });
  });
  $("navSearch").addEventListener("input",function(){
    var q=this.value.toLowerCase();
    Array.prototype.forEach.call(links,function(a){
      a.style.display=a.textContent.toLowerCase().indexOf(q)>-1?"flex":"none";
    });
  });

  /* ---------- Server table ---------- */
  var servers=[
    {n:"srv-prod-01",s:"Active",cpu:48,ram:87,disk:33},
    {n:"srv-app-03",s:"Warning",cpu:60,ram:14,disk:40},
    {n:"srv-db-02",s:"Active",cpu:42,ram:97,disk:35}
  ];
  function renderServers(){
    var h="";
    servers.forEach(function(s){
      var dot=s.s==="Active"?"d-green":(s.s==="Warning"?"d-gray":"d-red");
      var cls=s.s==="Active"?"st-active":"st-warn";
      var ico=s.s==="Warning"?"&#9888; ":(s.s==="Active"?"<span class='dot d-green' style='margin-right:5px'></span>":"");
      h+="<tr><td><span class='dot "+dot+"'></span>"+s.n+"</td>"+
         "<td class='"+cls+"'>"+ico+s.s+"</td>"+
         "<td>"+s.cpu+"%</td><td>"+s.ram+"%</td><td>"+s.disk+"%</td></tr>";
    });
    $("serverBody").innerHTML=h;
  }
  function tickServers(){
    servers.forEach(function(s){
      s.cpu=Math.max(5,Math.min(98,s.cpu+rnd(-4,4)));
      s.ram=Math.max(10,Math.min(99,s.ram+rnd(-2,2)));
      s.disk=Math.max(10,Math.min(95,s.disk+(Math.random()<.2?1:0)));
      if(s.n!=="srv-app-03") s.s=s.cpu>90?"Warning":"Active";
    });
    renderServers();
  }

  /* ---------- Chart ---------- */
  var N=40, mode="all";
  function seed(base,amp){var a=[],v=base;for(var i=0;i<N;i++){v+=rnd(-amp,amp);v=Math.max(10,Math.min(90,v));a.push(v);}return a;}
  var series={cpu:seed(45,8),mem:seed(55,5),net:seed(35,12)};
  var canvas=$("chart"),ctx=canvas.getContext("2d");
  function curve(pts){
    ctx.moveTo(pts[0][0],pts[0][1]);
    for(var i=1;i<pts.length-1;i++){
      var xc=(pts[i][0]+pts[i+1][0])/2,yc=(pts[i][1]+pts[i+1][1])/2;
      ctx.quadraticCurveTo(pts[i][0],pts[i][1],xc,yc);
    }
    ctx.lineTo(pts[pts.length-1][0],pts[pts.length-1][1]);
  }
  function drawLine(data,color,fill,W,H,L,B,T){
    var pts=data.map(function(v,i){return [L+(W-L)*i/(N-1),T+(H-T-B)*(1-v/100)];});
    if(fill){
      ctx.beginPath();curve(pts);
      ctx.lineTo(pts[pts.length-1][0],H-B);ctx.lineTo(pts[0][0],H-B);ctx.closePath();
      var g=ctx.createLinearGradient(0,T,0,H-B);g.addColorStop(0,"rgba(91,75,196,.25)");g.addColorStop(1,"rgba(91,75,196,0)");
      ctx.fillStyle=g;ctx.fill();
    }
    ctx.beginPath();curve(pts);ctx.strokeStyle=color;ctx.lineWidth=2;ctx.lineJoin="round";ctx.stroke();
  }
  function draw(){
    var dpr=window.devicePixelRatio||1;
    var w=canvas.clientWidth,h=canvas.clientHeight;
    canvas.width=w*dpr;canvas.height=h*dpr;ctx.setTransform(dpr,0,0,dpr,0,0);
    ctx.clearRect(0,0,w,h);
    var L=34,B=18,T=6;
    ctx.font="11px sans-serif";ctx.fillStyle="#6b7089";ctx.textBaseline="middle";
    [0,30,60,90].forEach(function(v){
      var y=T+(h-T-B)*(1-v/100);
      ctx.strokeStyle="#eef0f6";ctx.lineWidth=1;ctx.beginPath();ctx.moveTo(L,y);ctx.lineTo(w,y);ctx.stroke();
      ctx.fillText(v+"%",0,y);
    });
    var now=new Date();
    ctx.textBaseline="alphabetic";
    for(var i=0;i<4;i++){
      var d=new Date(now.getTime()-(3-i)*60000*5);
      ctx.fillText(pad(d.getHours())+":"+pad(d.getMinutes()),L+(w-L-34)*i/3,h-3);
    }
    if(mode==="all"){
      drawLine(series.mem,"#8f84e8",false,w,h,L,B,T);
      drawLine(series.cpu,"#4b3cb5",true,w,h,L,B,T);
    }else{
      drawLine(series.net,"#2c8f6a",false,w,h,L,B,T);
    }
  }
  function tickChart(){
    ["cpu","mem","net"].forEach(function(k){
      var a=series[k],last=a[a.length-1];
      var step=k==="net"?12:(k==="cpu"?8:4);
      a.push(Math.max(10,Math.min(90,last+rnd(-step,step))));a.shift();
    });
    draw();
  }
  Array.prototype.forEach.call(document.querySelectorAll("#metricSeg button"),function(b){
    b.addEventListener("click",function(){
      Array.prototype.forEach.call(document.querySelectorAll("#metricSeg button"),function(x){x.classList.remove("on");});
      b.classList.add("on");mode=b.getAttribute("data-m");draw();
    });
  });
  window.addEventListener("resize",draw);

  /* ---------- Kubernetes ---------- */
  var clusters=[
    {n:"Primary",t:"prod",cpu:68,mem:54,pods:[24,25],dots:[1,1,1,0]},
    {n:"K8s-Prod-01",t:"prod",cpu:72,mem:61,pods:[24,25],dots:[1,1,1,0]},
    {n:"K8s-Staging",t:"nonprod",cpu:44,mem:39,pods:[12,12],dots:[1,1,1,0]},
    {n:"K8s-Dev",t:"nonprod",cpu:31,mem:28,pods:[9,10],dots:[1,1,1,0]},
    {n:"East-01",t:"prod",cpu:66,mem:58,pods:[18,20],dots:[1,1,0,0]},
    {n:"West-01",t:"prod",cpu:59,mem:52,pods:[20,20],dots:[1,1,1,1]}
  ];
  var selCluster=0,clFilter="all";
  function gauge(val,color){
    var r=17,c=2*Math.PI*r,arc=c*0.75,fill=arc*val/100;
    return "<svg viewBox='0 0 44 44'><g transform='rotate(135 22 22)'>"+
      "<circle cx='22' cy='22' r='"+r+"' fill='none' stroke='#e3e5f0' stroke-width='4' stroke-linecap='round' stroke-dasharray='"+arc+" "+c+"'/>"+
      "<circle cx='22' cy='22' r='"+r+"' fill='none' stroke='"+color+"' stroke-width='4' stroke-linecap='round' stroke-dasharray='"+fill+" "+c+"'/></g></svg>";
  }
  function renderClusters(){
    var h="";
    clusters.forEach(function(c,i){
      if(clFilter!=="all"&&c.t!==clFilter) return;
      var dots=c.dots.map(function(d){return "<i style='background:"+(d?"#1f9d55":"#e3a008")+"'></i>";}).join("");
      var col=function(v){return v>85?"#d64545":(v>70?"#e3a008":"#5b4bc4");};
      h+="<div class='cl"+(i===selCluster?" sel":"")+"' data-i='"+i+"'>"+
        "<div class='nm'><span>"+c.n+"</span>"+(i===selCluster?"<span class='tick'>&#10003;</span>":"")+"</div>"+
        "<div class='lbl'>Node Health</div><div class='dots'>"+dots+"</div>"+
        "<div class='lbl'>Pods</div><div class='pods'><span>"+c.pods[0]+"/"+c.pods[1]+"</span><span>Running</span></div>"+
        "<div class='lbl'>CPU/Memory</div>"+
        "<div class='gauges'><div class='g'>"+gauge(c.cpu,col(c.cpu))+c.cpu+"%</div><div class='g'>"+gauge(c.mem,col(c.mem))+c.mem+"%</div></div>"+
      "</div>";
    });
    $("k8s").innerHTML=h||"<div class='sub'>No clusters match.</div>";
  }
  $("k8s").addEventListener("click",function(e){
    var el=e.target;while(el&&el!==this&&!el.getAttribute("data-i"))el=el.parentNode;
    if(el&&el.getAttribute("data-i")){selCluster=parseInt(el.getAttribute("data-i"),10);renderClusters();}
  });
  $("clFilter").addEventListener("change",function(){clFilter=this.value;renderClusters();});
  function tickClusters(){
    clusters.forEach(function(c){
      c.cpu=Math.max(10,Math.min(95,c.cpu+rnd(-3,3)));
      c.mem=Math.max(10,Math.min(95,c.mem+rnd(-2,2)));
    });
    renderClusters();
  }

  /* ---------- Pipeline ---------- */
  var icons={
    commit:"<svg viewBox='0 0 24 24' stroke='#555'><circle cx='12' cy='12' r='3'/><path d='M3 12h6M15 12h6'/></svg>",
    build:"<svg viewBox='0 0 24 24'><path d='M14.7 6.3a4 4 0 0 0-5.4 5.4L3 18l3 3 6.3-6.3a4 4 0 0 0 5.4-5.4l-2.4 2.4-2.1-.6-.6-2.1z'/></svg>",
    test:"<svg viewBox='0 0 24 24'><path d='m5 12 5 5 9-10'/></svg>",
    deploy:"<svg viewBox='0 0 24 24'><path d='m5 12 5 5 9-10'/></svg>",
    post:"<svg viewBox='0 0 24 24'><circle cx='12' cy='12' r='9'/><path d='M12 8v5M12 16h.01'/></svg>"
  };
  var stages=[["Commit","v1.2.4","commit"],["Build","1m42s","build"],["Test","2m15s","test"],["Deploy","58s","deploy"],["Post-Deploy","3s","post"]];
  var pipeStep=4;
  function renderPipe(){
    var h="";
    stages.forEach(function(s,i){
      var cls=i<pipeStep?"done":(i===pipeStep?"run":"");
      if(i===0) cls="";
      h+="<div class='stage'><div class='node "+cls+"'>"+icons[s[2]]+"</div>"+s[0]+"<small>"+s[1]+"</small></div>";
      if(i<stages.length-1) h+="<div class='arrow'>&rarr;</div>";
    });
    $("pipe").innerHTML=h;
  }
  var builds=[
    ["webApp v2.1","Success","1m42s"],
    ["project-web","Success","2m15s"],
    ["frontend-v2.1","Success","58s"]
  ];
  function renderBuilds(){
    var d=new Date(),ds=d.getFullYear()+"-"+pad(d.getMonth()+1)+"-"+pad(d.getDate());
    var h="";
    builds.forEach(function(b){
      var cls=b[1]==="Success"?"st-ok":(b[1]==="Failed"?"st-fail":"st-run");
      var dc=b[1]==="Success"?"d-green":(b[1]==="Failed"?"d-red":"d-amber");
      h+="<tr><td>"+ds+" - "+b[0]+"</td><td class='"+cls+"'><span class='dot "+dc+"'></span>"+b[1]+"</td><td class='r'>"+b[2]+"</td></tr>";
    });
    $("builds").innerHTML=h;
  }
  $("projSel").addEventListener("change",function(){
    $("projName").textContent=this.value;
    pipeStep=1;renderPipe();
    var t=setInterval(function(){
      pipeStep++;renderPipe();
      if(pipeStep>=4){clearInterval(t);}
    },900);
  });

  /* ---------- Console ---------- */
  var con=$("console");
  function addLog(level,msg){
    var d=document.createElement("div");d.className="ln";
    var pre=level==="INFO"||level==="ERROR"?"":"";
    d.innerHTML="<span class='t'>"+clock()+"</span><span class='lv-"+level+"'>"+level+"</span>&nbsp;&nbsp;"+
      msg.replace(/&/g,"&amp;").replace(/</g,"&lt;");
    con.appendChild(d);
    while(con.children.length>60) con.removeChild(con.firstChild);
    con.scrollTop=con.scrollHeight;
  }
  var script=[
    ["INFO","Fetching artifacts..."],["WARN","Starting build: project-web"],["SUCCESS","Build finished."],
    ["INFO","Deploying to K8s-Prod-01..."],["INFO","Rolling update: 3/5 pods ready"],["INFO","Rolling update: 5/5 pods ready"],
    ["SUCCESS","Deployment complete."],["INFO","Running health checks..."],["WARN","Slow response from srv-app-03"],["SUCCESS","Health checks passed."]
  ];
  var li=0;
  for(var k=0;k<5;k++){addLog(script[k][0],script[k][1]);li++;}
  setInterval(function(){
    var s=script[li%script.length];addLog(s[0],s[1]);li++;
  },3500);
  $("logSel").addEventListener("change",function(){
    con.innerHTML="";addLog("INFO","Loading logs for "+this.value+"...");li=0;
  });
  $("copyBtn").addEventListener("click",function(){
    var btn=this,txt=con.innerText;
    function done(){btn.textContent="Copied";setTimeout(function(){btn.textContent="Copy";},1200);}
    if(navigator.clipboard&&navigator.clipboard.writeText){navigator.clipboard.writeText(txt).then(done,done);}
    else{var ta=document.createElement("textarea");ta.value=txt;document.body.appendChild(ta);ta.select();try{document.execCommand("copy");}catch(e){}document.body.removeChild(ta);done();}
  });

  /* ---------- Uptime ---------- */
  var ups=[["Core Services","99.98%"],["Database Cluster","99.95%"],["API Gateway","100%"],["Auth Service","99.99%"]];
  $("uptime").innerHTML=ups.map(function(u){
    return "<div class='up'><div class='row'><span>"+u[0]+"</span><span>("+u[1]+")</span></div><div class='bar'></div></div>";
  }).join("");

  /* ---------- Header actions ---------- */
  $("refreshBtn").addEventListener("click",function(){
    tickServers();tickClusters();tickChart();
    $("sAlerts").textContent=rnd(1,5);
    $("sServers").innerHTML=rnd(46,50)+" &#8593;";
  });

  /* ---------- Init ---------- */
  renderServers();renderClusters();renderPipe();renderBuilds();draw();
  setInterval(tickChart,2000);
  setInterval(tickServers,4000);
  setInterval(tickClusters,6000);
})();
</script>
</body>
</html>
