# DevFest 2025 Daegu: Flutter GenUI Codelab 🚀

이 리포지토리는 **DevFest 2025 Daegu**의 **"Flutter와 Gemini로 구현하는 차세대 Generative UI(GenUI)"** 핸즈온 세션을 위한 실습 코드입니다.

사용자의 요구사항에 맞춰 AI가 실시간으로 최적의 UI 컴포넌트를 생성하고, 최신 정보(Google Search)를 활용하여 응답하는 **AI 여행 큐레이터(AI Travel Curator)** 앱을 구축하는 과정을 담고 있습니다.

---

## 🌟 프로젝트 주요 특징

- **Generative UI (GenUI)**: 텍스트 응답을 넘어, AI가 앱의 위젯 구조를 직접 설계하고 렌더링합니다.
- **Gemini 1.5/2.0 Integration**: Google의 강력한 LLM을 사용하여 상황에 맞는 지능적인 응답을 제공합니다.
- **Real-time Google Search**: AI가 상상해서 답하는 것이 아니라, 실제 구글 검색 결과를 바탕으로 최신 정보와 이미지 URL을 가져옵니다.
- **Custom Widget Catalog**: `PlaceCard`, `TravelCarousel` 등 여행 앱에 특화된 위젯들을 AI가 자유자재로 조합할 수 있도록 카탈로그화되어 있습니다.

---

### 실행 방법

1.  Flutter 프로젝트 설정이 완료되었는지 확인합니다.
2.  다음 명령어를 통해 API 키를 환경 변수로 전달하며 앱을 실행합니다:

    ```bash
    flutter run --dart-define=GENAI_API_KEY=YOUR_API_KEY
    ```

    또는 특정 플랫폼(예: macOS)에서 실행하려면:

    ```bash
    flutter run -d macos --dart-define=GENAI_API_KEY=YOUR_API_KEY
    ```

---

## 🛠 실습 준비사항

시작하기 전에 다음 환경이 준비되어 있어야 합니다.

1. **Flutter SDK**: 최신 Stable 버전 권장 (v3.10.3 이상)
2. **Gemini API Key**: [Google AI Studio](https://aistudio.google.com/)에서 발급받은 API 키가 필요합니다.
3. **IDE**: VS Code 또는 Android Studio (Flutter 플러그인 설치 필수)

---

## 🚀 시작하기

### 1. 리포지토리 클론 및 의존성 설치
```bash
git clone https://github.com/jaichangpark/devfest-2025-daegu.git
cd devfest-2025-daegu
flutter pub get
```

### 2. API 키 설정
`lib/main.dart` 파일의 `apiKey` 부분에 본인의 Gemini API 키를 입력합니다.
*(주의: 실제 서비스 배포 시에는 API 키를 환경 변수나 보안 스토리지에 관리해야 합니다.)*

```dart
// lib/main.dart
final generator = GoogleGenerativeAiContentGenerator(
  apiKey: 'YOUR_GEMINI_API_KEY_HERE', 
  modelName: 'models/gemini-2.0-flash', // 또는 최신 모델명
  // ...
);
```

### 3. 앱 실행
```bash
flutter run
```

---

## 📂 프로젝트 구조

- `lib/main.dart`: 앱의 엔트리 포인트이며, GenUI `Generator` 및 `Conversation` 객체를 설정합니다.
- `lib/chat_screen.dart`: 사용자 인터페이스를 담당하며, AI의 텍스트와 UI 메시지를 렌더링합니다.
- `lib/catalog.dart`: AI가 사용할 수 있는 위젯들의 명세(Schema)와 빌더를 정의합니다.
- `lib/widgets/`: `PlaceCard`, `TravelCarousel`, `VerticalLayout` 등 실제 렌더링될 커스텀 위젯들이 포함되어 있습니다.
- `lib/search_injector.dart`: Google Search 기능을 AI 도구(Tool)로 주입하는 로직이 들어있습니다.

---

## 🎓 Hands-on 학습 목표

이 세션을 통해 다음 내용을 학습합니다.

1. **GenUI의 개념 이해**: 정적인 UI에서 동적인 AI 생성 UI로의 패러다임 변화를 이해합니다.
2. **Catalog 시스템 활용**: AI에게 우리 앱의 UI 컴포넌트를 "가르치는" 방법을 배웁니다.
3. **Tool Calling & Search**: 외부 API와 검색 엔진을 LLM에 연결하여 데이터 신뢰성을 높이는 기법을 익힙니다.
4. **Interactive UI**: AI가 생성한 UI 내에서 발생하는 이벤트를 가로채고 다시 AI에게 피드백을 주는 상호작용 구조를 설계합니다.

---

## 📝 라이선스

이 프로젝트는 [MIT License](LICENSE)를 따릅니다.

---

**DevFest 2025 Daegu**에서 즐거운 Flutter & AI 개발 경험 되시길 바랍니다! 💙
