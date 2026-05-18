from pathlib import Path
import re
p = Path("c:/Users/asare/OneDrive/Desktop/Final Year Project/smart_campus_guide1/lib/data/campus_data.dart")
text = p.read_text(encoding='utf-8')
text = text.replace('const List<CampusBuilding> campusBuildings = [', 'final List<CampusBuilding> campusBuildings = [')
lines = text.splitlines()
out = []
cur_id = None
updated = 0
for line in lines:
    stripped = line.strip()
    m = re.match(r"id:\s*'([^']+)'", stripped)
    if m:
        cur_id = m.group(1)
        out.append(line)
        continue
    if stripped.startswith('imagePath:') and 'AssetImages.' in stripped and 'forBuildingId' not in stripped and cur_id:
        indent = line[:line.index('i')]
        out.append(f"{indent}imagePath: AssetImages.forBuildingId('{cur_id}'),")
        updated += 1
        continue
    out.append(line)
result = '\n'.join(out) + '\n'
p.write_text(result, encoding='utf-8')
print(f'updated_entries={updated}')
