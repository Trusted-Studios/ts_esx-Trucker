# esx_GMW-Trucker
---

## Informationen:

Der Trucker Job ist ein einfaches und vielseitiges Script, welches die Vielfältigkeit ziviler Jobs komplmentiert. Es bietet zahlreiche Konfigurationsoptionen die für jeden Server Individuell angepasst werden können und stellt für den Spieler ein angenehmes Spielerlebnis dar.

## Konfigurationsoptionen:

> Alle Konfigurationen befinden sich in der `config.lua`. 

**Depot**

*Beispiel:*
```lua
Config.DepotPoint = {
    {Label = "LS Logistics", Coords = vector4(1014.18, -2523.53, 28.31, 90.01)}
}
```

- Config.DepotPoint: `table`
    - Label: `string`
        - Text der dem Spieler angezeigt wird, wenn dieser den Blip anklickt. 
    - Coords: `vec4`
        - Koordinaten des Depots. Hierbei wird ein NPC als Referenzpunkt gespawned. Der Vektor stellt die Koordinaten `x`, `y`, `z` und `h` dar.
---

**NeedJob**

*Beispiel:*
```lua
Config.needJob = true
```

- Config.needJob `boolean`
    - Beschreibt ob man für die Nutzung der Routen einen Job benötigt oder nicht. 
--- 

**Health**

*Beispiel:*
```lua
Config.Health = "engine"
```

- Config.Health: `string -> 'engine' | 'body'`
    - Legt fest ob der Schaden des Motors oder der Karosserie gemessen wird. 
--- 

**Fahrzeug Spawnpoint**

*Beispiel:*
```lua
Config.VehSpawnPoint = vector4(983.98, -2530.77, 28.32, 355.00)
```

- Config.VehSpawnPoint: `vec4`
    - Koordinaten bei denen die LKW's gespawned werden. 
--- 

**Trailer Spawnpoint**

*Beispiel:*
```lua
Config.TrailerSpwnPoint = vector4(982.92, -2543.71, 28.3, 355.00)
```

- Config.TrailerSpwnPoint: `vec4`
    - Koordinaten bei denen die Trailers gespawned werden. 
--- 

**Endpunkte**

*Beispiel:*
```lua
Config.Endpoint = vector4(983.98, -2530.77, 28.32, 355.00)
```

- Config.EndPoint: `vec4`
    - Koordinaten bei denen man die Jobs beendet. 
--- 

**Cooldown**

*Beispiel:*

```lua
Config.Cooldown = 10
``` 

- Config.Cooldown: `integer`
    - Legt den Cooldown einer Route fest, nachdem diese beendet wurde, damit ein Spieler nicht immer die selben Routen fahren kann. Die Einheit des Cooldowns ist hier hierbei _in Sekunden_ festgelegt. 
--- 

**Texture Bug**

*Beispiel:*
```lua
Config.TxdBug = true
```

- Config.TxdBug: `boolean`
    - Ab einer gewissen Artifacts Version, gitbt es einen Bug mit den Custom Texturen, wesegen man diese hier einstellen kann. Sollte der Menü-Header weiß sein, so solltet ihr diese Config auf `true` umstellen. 
--- 

**Routen**

*Beispiel:*
```lua
Config.Routen = {
    {Label = "Klärwerk ~y~(Rancho)", price = "~g~80$", Coords = vector3(476.01, -2151.01, 5.93), Reward = 80},
}
```

- Config.Routen: `table`
    - Label: `string`
        - Name der Route (Wird dem Spieler angezeigt)
    - price: `string`
        - Lohn der im Menü dem Spieler angezeigt wird. 
    - Coords: `vec3`
        - Zielkoordinaten der Route. 
    - Reward: `integer`
        - Lohn, welches der Spieler beim erfolreichen Abschluss der Route bekommt. 

> **WICHTIG**
> 
> Es können in der Config.Routen unendlich viele Routen erstellt werden. Ihr könntet also wenn ihr es wollen würdet 10.000 verschiedene Routen einstellen! 
--- 

**Trailer**

*Beispiel:*
```lua
Config.Trailers = {
    {spwn = "trailers"},
}
```

Config.Trailers: `table`
    - spwn: `string`
        - Spawnname eines Trailers. Diese werden dan Random im Script ausgewählt. 

--- 

**Trucks**

*Beispiel:*
```lua
Config.Trucks = {
    {spwn = "phantom"},
}
```

Config.Trucks: `table`
    - spwn: `string`
        - Spawnname eines Trucks. Diese werden dan Random im Script ausgewählt. 

> **WICHTIG**
> 
> Sowohl bei den Trucks wie auch bei den Trailers könnt ihr unendlich viele verschiedene Fahrzeuge einstellen. Diese werden dann beim AUswählen einer Route Random vom Script ausgewählt! 
