function HighlightLines(e,t,n){let o=e.split("\n");""===o[0]&&o.shift();for(let e=t;e<=n;e++)e>=0&&e<o.length&&(o[e]=`<b>${o[e]}</b>`);const c=o.join("\n"),i=document.createElement("code");i.innerHTML=c;const s=document.createElement("pre");return s.appendChild(i),s}function ExplodeDesignInfo(e){let t=e.split("-");const n={};n.model_number=t[0];const o=n.model_number;n.orientation="v"==o.toLowerCase()?"vertical":"horizontal",n.capacity=n.model_number.slice(1)+" bottles",n._dims=t[1];const c=n._dims.split("x");return n.height=c[0]+" inches",n.width=c[1]+" inches",n.depth=c[2]+" inches",n.estimated_load=t[2]+" pounds",n._flags=t[3],n}function PropTable(e){const t=document.createElement("table");t.border="1";const n=document.createElement("tbody");for(const[t,o]of Object.entries(e))if(!t.startsWith("_")){const e=document.createElement("tr"),c=document.createElement("th"),i=t.replace("_"," ");c.textContent=i,e.appendChild(c);const s=document.createElement("td");s.textContent=o,e.appendChild(s),n.appendChild(e)}return t.appendChild(n),t}function InsertContent(e,t){console.log("SELECTOR: "+e);const n=document.querySelector(e);n?n.appendChild(t):console.error("The selector: "+e+" not found in the document.")}function InsertHighlightedLines(e,t,n,o){InsertContent(e,HighlightLines(t,n,o))}function InsertFigure(e,t,n){const o=document.createElement("img");o.src="assets/img/previews/"+n+".png",o.width=t,console.log("IMAGE:"+o.src);const c=PropTable(ExplodeDesignInfo(n)),i=document.createElement("figure");i.appendChild(o),i.appendChild(c),InsertContent(e,i)}