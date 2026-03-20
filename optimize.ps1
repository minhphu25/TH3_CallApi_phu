$json = Get-Content 'D:\android\th3\db\data.json' -Raw | ConvertFrom-Json
$json.pokemon = @($json.pokemon[0..49])
$json | ConvertTo-Json -Depth 100 | Out-File 'D:\android\th3\db\data.json' -Encoding UTF8
Write-Host "Tối ưu hóa thành công! Giữ lại 50 Pokémon đầu tiên"
Write-Host "Số lượng Pokémon hiện tại: $($json.pokemon.Count)"
