import os

pdf_path = r"C:\Users\chia-hao\Downloads\附件一__強化勤務業務紀律優、劣蹟衡量標準表.pdf"

print("Checking PDF path:", pdf_path)
print("Exists:", os.path.exists(pdf_path))

text = ""
try:
    import pypdf
    reader = pypdf.PdfReader(pdf_path)
    for i, page in enumerate(reader.pages):
        text += f"\n--- Page {i+1} ---\n" + page.extract_text()
except Exception as e1:
    try:
        import pdfplumber
        with pdfplumber.open(pdf_path) as pdf:
            for i, page in enumerate(pdf.pages):
                text += f"\n--- Page {i+1} ---\n" + page.extract_text()
    except Exception as e2:
        try:
            import fitz # PyMuPDF
            doc = fitz.open(pdf_path)
            for i, page in enumerate(doc):
                text += f"\n--- Page {i+1} ---\n" + page.get_text()
        except Exception as e3:
            text = f"Errors: pypdf({e1}), pdfplumber({e2}), fitz({e3})"

out_path = r"C:\Users\chia-hao\Documents\GitHub\tw-formal-writing\extracted_pdf.txt"
with open(out_path, 'w', encoding='utf-8') as f:
    f.write(text)

print("PDF extraction completed. Saved to:", out_path)
