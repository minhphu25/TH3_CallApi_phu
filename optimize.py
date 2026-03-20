import json

# Đọc file JSON
with open('D:\\android\\th3\\db\\data.json', 'r', encoding='utf-8') as f:
    data = json.load(f)

# Giữ lại 50 Pokémon đầu tiên
original_count = len(data['pokemon'])
data['pokemon'] = data['pokemon'][:50]

# Lưu file
with open('D:\\android\\th3\\db\\data.json', 'w', encoding='utf-8') as f:
    json.dump(data, f, indent=4, ensure_ascii=False)

print(f'✓ Tối ưu hóa thành công!')
print(f'  Từ {original_count} Pokémon → {len(data["pokemon"])} Pokémon')
print(f'  Danh sách: Bulbasaur (#001) đến Diglett (#050)')
