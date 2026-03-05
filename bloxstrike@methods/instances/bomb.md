- Source: `workspace.Debris`
- Filter:
  - Instance type: `Model`
  - Name: `"Character"`
  - Has attribute `"BombPlanted"`
- Bomb Data (from `Model:GetAttribute("BombPlanted")`):
  - `Site`: String - Bomb site location ("A" or "B")
  - `TimeUntilExplode`: Number - Seconds remaining until detonation
  - `Time`: Number - Timestamp when bomb was planted
- Result:
  - Model instance for planted bomb

```json
{
  "Site": "A",
  "TimeUntilExplode": 40,
  "Time": 1772672248.456025
}
```