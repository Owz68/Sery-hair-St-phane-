var C="ssh-v23",F=["./","index.html","logo.png","icon-192.png"];
self.addEventListener("install",function(e){e.waitUntil(caches.open(C).then(function(c){return c.addAll(F)}))});
self.addEventListener("fetch",function(e){if(e.request.method!="GET"||e.request.url.indexOf(location.origin)!=0)return;
e.respondWith(fetch(e.request).then(function(r){var k=r.clone();caches.open(C).then(function(c){c.put(e.request,k)});return r}).catch(function(){return caches.match(e.request)}))});
