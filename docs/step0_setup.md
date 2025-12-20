# Step 0: 환경 설정 및 API 키 준비

본격적인 코딩에 앞서 개발 환경을 준비하고, 생성형 AI(Gemini) 사용을 위한 API 키를 설정합니다.

## 1. 사전 요구 사항
*   **Flutter SDK**: 최신 Stable 버전을 권장합니다 (3.24.0 이상).
*   **IDE**: VS Code 혹은 Android Studio (Flutter 플러그인 설치 필수).
*   **Gemini API Key**: [Google AI Studio](https://aistudio.google.com/app/apikey)에서 무료로 발급받을 수 있습니다.

## 2. 프로젝트 내려받기 및 초기화
터미널에서 프로젝트 폴더로 이동한 후 의존성을 설치합니다.

```bash
flutter pub get
```

## 3. 시작 코드 준비
실습을 위해 미리 준비된 **시작 코드**를 프로젝트의 `lib` 폴더에 복사하거나 참고하여 작성합니다.

*   [docs/starter_code/lib/](./starter_code/lib/) 폴더의 파일들(상태 관리, 모델, 유틸리티 등)을 자신의 프로젝트 `lib/` 폴더에 덮어쓰기 하세요.
*   혹은 하나의 파일로 실습하고 싶다면 [main_all_in_one.dart](./starter_code/main_all_in_one.dart)의 내용을 `lib/main.dart`에 붙여넣고, **`lib/utils.dart`** 파일을 별도로 생성하여 준비하세요.

## 4. Gemini API 키 설정
보안을 위해 API 키는 코드에 직접 하드코딩하지 않고 환경 변수를 통해 전달합니다.

터미널이나 IDE의 실행 설정(Run Configuration)에서 다음과 같이 `--dart-define` 옵션을 사용합니다.

```bash
flutter run --dart-define=GOOGLE_API_KEY=YOUR_API_KEY_HERE
```

> [!TIP]
> **VS Code 사용자라면?**
> `.vscode/launch.json` 파일의 `args` 항목에 `"--dart-define=GOOGLE_API_KEY=YOUR_API_KEY_HERE"`를 추가하면 편리합니다.

## 4. 실행 확인
앱을 실행했을 때 기본적인 채팅 UI(빈 화면)가 나타나면 성공입니다.

---
준비가 완료되었다면 **[Step 1: 채팅 인터페이스 구현](./step1_chat_ui.md)**으로 넘어가 볼까요?
