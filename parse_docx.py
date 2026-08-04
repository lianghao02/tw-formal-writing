import zipfile
import xml.etree.ElementTree as ET
import os

files = [
    r'C:\Users\chia-hao\Downloads\115年7月第4週各級督導人員優、缺點、問題與建議督導通報.docx',
    r'C:\Users\chia-hao\Downloads\115年6月第5週、7月第1週高司、各科、室、中心、直屬大隊（隊）正（副）主官督導通報.docx',
    r'C:\Users\chia-hao\Downloads\115年7月第2週高司、各科、室、中心、直屬大隊（隊）正（副）主官督導通報.docx',
    r'C:\Users\chia-hao\Downloads\115年7月第3週高司、各科、室、中心、直屬大隊（隊）正（副）主官督導通報.docx',
    r'C:\Users\chia-hao\Downloads\115年7月第4週高司、各科、室、中心、直屬大隊（隊）正（副）主官督導通報.docx',
    r'C:\Users\chia-hao\Downloads\115年6月第5週、7月第1週各級督導人員優、缺點、問題與建議督導通報.docx',
    r'C:\Users\chia-hao\Downloads\115年7月第2週各級督導人員優、缺點、問題與建議督導通報.docx',
    r'C:\Users\chia-hao\Downloads\115年7月第3週各級督導人員優、缺點、問題與建議督導通報.docx',
    r'C:\Users\chia-hao\Downloads\督導報告 (4).docx',
    r'C:\Users\chia-hao\Downloads\督導報告 (3).docx',
    r'C:\Users\chia-hao\Downloads\督導報告 (2).docx',
    r'C:\Users\chia-hao\Downloads\督導報告 (1).docx',
    r'C:\Users\chia-hao\Downloads\督導報告.docx'
]

def read_docx(path):
    if not os.path.exists(path):
        return f'[File Not Found: {path}]'
    try:
        with zipfile.ZipFile(path) as z:
            xml_content = z.read('word/document.xml')
            tree = ET.fromstring(xml_content)
            paragraphs = []
            for elem in tree.iter():
                if elem.tag.endswith('p'):
                    texts = [e.text for e in elem.iter() if e.tag.endswith('t') and e.text]
                    if texts:
                        paragraphs.append(''.join(texts))
            return '\n'.join(paragraphs)
    except Exception as e:
        return f'[Error reading {path}: {e}]'

out_file = r'C:\Users\chia-hao\Documents\GitHub\tw-formal-writing\extracted_docs.txt'

with open(out_file, 'w', encoding='utf-8') as out:
    for f in files:
        out.write('='*60 + '\n')
        out.write(f'FILE: {os.path.basename(f)}\n')
        out.write('='*60 + '\n')
        content = read_docx(f)
        out.write(content + '\n\n')

print("Extraction finished! Check:", out_file)
