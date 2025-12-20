# Step 4: 시스템 프롬프트 최적화 및 완성

마지막 단계입니다! AI에게 "고객센터 상담원"이라는 페르소나를 부여하고, 우리가 만든 위젯들을 언제 어떻게 사용할지 가르쳐 줍니다.

## 1. 시스템 프롬프트 설계
AI가 단순히 말을 하는 것이 아니라, 도구(Tools)를 사용해 UI를 그리도록 매우 구체적인 지시를 내립니다. 다음 프롬프트를 복사하여 사용하세요.

```text
# Instructions
당신은 친절한 고객센터 상담원입니다. 사용자의 요청에 따라 관련 정보를 FAQ에서 찾아주거나 문의 접수를 도와주세요.

## 핵심 원칙
1. 텍스트로만 설명하지 마세요. 반드시 제공된 UI 컴포넌트를 활용하여 구조화된 정보를 전달하세요.
2. 컴포넌트를 그릴 때는 반드시 `surfaceUpdate` 도구를 사용하여 컴포넌트를 정의하고, `beginRendering`으로 화면에 표시해야 합니다.

## 상황별 UI 가이드
- 첫 인사: 사용자가 "안녕"이나 "시작"이라고 하면 반갑습니다 인사 후 `category_grid`를 보여주세요.
- FAQ 답변: 질문에 답할 때는 `faq_card`를 사용하세요. 텍스트 답변은 가급적 짧게 유지하세요.
- 문의 접수/조회: `inquiry_status_card`를 사용하여 진행 상황을 보여주세요. (statusType: pending, inProgress, resolved)

## UI 컴포넌트 목록
- faq_card: 질문(question)과 답변(answer) 표시
- category_grid: 문의 카테고리 목록 표시 (아이콘 이름: info, help, payment, person)
- inquiry_status_card: 문의 제목, 상태, 날짜 표시
```

> [!IMPORTANT]
> GenUI는 AI가 `surfaceUpdate`와 `beginRendering`이라는 **도구(Tool)**를 실제로 호출해야만 화면에 위젯이 나타납니다. 지시어가 너무 단순하면 AI가 도구를 호출하는 대신 그냥 텍스트로 대답해버릴 수 있으므로, 위와 같이 명확한 가이드가 필요합니다.

## 2. 코드는 어디에 넣나요?

*   **방법 A: [구조화된 코드](./starter_code/lib/) 사용 시**
    *   `lib/main.dart` 내 `GoogleGenerativeAiContentGenerator`의 `systemInstruction` 속성에 위 내용을 입력하세요.
*   **방법 B: [한 파일로 시작하기 (All-in-one)](./starter_code/main_all_in_one.dart) 사용 시**
    *   `lib/main.dart` 파일의 **`// [Step 4] 시스템 프롬프트 수정`** 주석 아래 `systemInstruction`을 수정하세요.

## 3. 인터렉션 처리 (Event Handling)
위젯 내에서 버튼 클릭 등의 이벤트가 발생했을 때 AI에게 다시 정보를 전달하는 방법입니다.

```dart
// FaqCard 클릭 시 이벤트 발생 예시 (Step 2의 FaqCard를 수정해 보세요)
onTap: () {
  context.dispatchEvent(
    UserActionEvent(
      name: 'notHelpful',
      context: {'question': question},
    ),
  );
},
```

## 4. 완성 및 테스트
이제 앱을 실행하고 다음과 같이 말해보세요.
*   "처음 왔어요. 어떤 메뉴가 있나요?" -> (카테고리 그리드 등장 예상)
*   "환불 정책 알려줘" -> (FAQ 카드 등장 예상)
*   "내 문의 내역 보여줘" -> (문의 상태 카드 등장 예상)

---
준비가 되었다면, 마지막으로 앱의 완성도를 높이는 방법을 알아보겠습니다. **[Step 5](./step5_advanced_refinement.md)**로 이동하세요.

---
[인덱스로 돌아가기](./index.md)
