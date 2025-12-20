# Step 4: 시스템 프롬프트 최적화 및 완성

마지막 단계입니다! AI에게 "고객센터 상담원"이라는 페르소나를 부여하고, 우리가 만든 위젯들을 언제 어떻게 사용할지 가르쳐 줍니다.

## 1. 시스템 프롬프트 설계
AI에게 "고객센터 상담원"이라는 페르소나를 부여합니다.

```text
넌 DevFest 2025 앱의 친절한 고객센터 상담원이야.
사용자의 질문에 따라 다음 위젯들을 활용해:
- 인사할 때는 'category_grid'를 보여줘.
- 자주 묻는 질문은 'faq_card'로 답해줘.
- 문의 내역 조회를 원하면 'inquiry_status_card'를 사용해.
텍스트로만 답하지 말고 대화 흐름에 맞는 UI를 적극적으로 생성해줘.
```

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
