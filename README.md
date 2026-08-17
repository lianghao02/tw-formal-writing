# 台灣正式文件撰寫助手 tw-formal-writing v2.0.1

[![Version](https://img.shields.io/badge/version-v2.0.1-blue.svg)](https://github.com/lianghao02/tw-formal-writing)
[![License](https://img.shields.io/badge/license-MIT-green.svg)](LICENSE)

提供台灣正式文件撰寫規則，涵蓋政府公文、政府機關其他文件、法律文件與人民對政府文書。專案以 `references/` 為規範內容來源，並產生不同平台可使用的 Skill 版本。

## 下載、安裝與使用

- **Codex**：將完整資料夾複製至 `%USERPROFILE%\.agents\skills\tw-formal-writing\`，重新開啟工作階段後即可依描述自動載入。
- **Antigravity／Gemini CLI**：將完整資料夾複製至 `%USERPROFILE%\.gemini\config\skills\tw-formal-writing\`。
- **ChatGPT／Gemini 網頁版**：上傳產生後的 `STANDALONE.md` 作為知識檔；空間受限時改用 `LITE.md` 作為 Instructions。
- **維護依賴**：內容使用不需 Python；只有重新建置、檢查或封裝時需要 Python 3.13。建立 GitHub Release 另需已登入的 GitHub CLI。
- **建置**：執行 `python scripts/build.py` 產生 `STANDALONE.md`，再執行 `python scripts/check_consistency.py`；發布前可用 `python scripts/package.py --check`。
- **打包**：不要手動修改 `STANDALONE.md`；`SKILL.md` 與 `references/` 才是維護來源。

## 內容範圍

- 政府公文：簽、函、書函、公告及常見簽辦方式。
- 政府機關其他文件：會議紀錄、新聞稿、施政報告等。
- 法律文件：存證信函、合約、MOU、NDA、聲明書等格式參考。
- 人民對政府文書：陳情書、申請書、訴願書、異議書與申覆書。

不涵蓋學術論文、商業計畫、履歷、私人書信或一般翻譯。

## 檔案用途

- `SKILL.md`：支援 references 的完整 Skill 入口。
- `STANDALONE.md`：由 `scripts/build.py` 產生的單檔完整版，請勿手動編輯。
- `LITE.md`：適合 GPTs Instructions 的精簡版。
- `examples/`：常見使用情境範例。
- `CITATIONS.md`：規範來源與查核紀錄。

## 建置與驗證

本專案以 Python 3.13 作為主要維護環境：

```powershell
python scripts/build.py
python scripts/check_consistency.py
```

一致性檢查會驗證 `SKILL.md`、`LITE.md`、`STANDALONE.md` 的版本一致、單檔建置結果及必要規則錨點。

## 使用限制

- 機密文書、未公開資訊與高敏感個資不應交由生成式 AI 處理。
- 法律文件輸出僅供格式與用語參考，不構成法律意見。
- 法規、機關表單與送件期限可能變動，正式使用前應查核主管機關最新規定。
