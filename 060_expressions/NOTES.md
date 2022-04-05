## Examples - terraform console
1. String Templates: Interpolation and Directives
```bash
    terraform console
    "Hello %{if var.hello == "barsoon"}Mars%{else}World123%{endif}"
    "Hello world"
    "Hello World \n"

```
2. For Expressions: returns as a list [], returns also as map {}
```bash
    terraform console
    [for w in var.worlds : upper(w)]
    [for k,v in var.worlds_map : "${k} = ${v}"]
    [for k,v in var.worlds_map : upper(k)]
    [for k,v in var.worlds_map : upper(k) if v == "mars"]
    [for k,v in var.worlds_map : upper(k) if v != "mars"]
    {for i,w in var.worlds : "${i}" => upper(w)}
```
3. Splats: return a list with multiple map,values[{},{}]
```
    terraform console
    var.worlds_splat
    [for m in var.worlds_splat : m.mars_name]
    [for m in var.worlds_splat : m.earth_name]
    var.worlds_splat[*].mars_name
    var.worlds_splat[*].earth_name
    [for m in var.worlds_splat : upper(m.earth_name)]
```
