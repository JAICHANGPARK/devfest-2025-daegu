# Step 5: 위젯 개선 및 고급 인터렉션 (Advanced Refinement)

축하합니다! 이미 기본적인 고객센터 앱 기능을 모두 완성했습니다. 마지막으로 이 앱을 **진짜 프리미엄 앱**처럼 느껴지게 만드는 고급 기법들을 살펴봅니다.

## 1. 반응형 UI의 비밀 (A2UI)
우리가 `FaqCard`와 `InquiryStatusCard`에 적용한 `ValueNotifier` 방식은 단순한 코드가 아닙니다. 이는 **A2UI (Agent-to-UI)** 패턴의 핵심입니다.

- **실시간 스트리밍**: AI가 답변을 생성하는 도중에도 화면의 텍스트가 실시간으로 "타이핑"되듯 업데이트됩니다.
- **상태 관리의 분리**: 위젯 전체를 다시 그리지 않고, 오직 데이터가 바뀐 부분(`ValueListenableBuilder`)만 효율적으로 업데이트합니다.

> [!TIP]
> `A2uiSchemas.stringReference`를 사용하면 AI가 데이터를 한 번에 보내지 않고 조금씩 보낼 때도 UI가 자연스럽게 반응합니다.

## 2. 사용자 피드백 루프 (User Feedback Loop)
UI는 보는 것만큼 **반응하는 것**이 중요합니다. `context.dispatchEvent`를 통해 사용자가 위젯의 특정 버튼을 눌렀을 때 AI에게 "이 답변은 도움이 안 됐어"와 같은 맥락을 다시 전달할 수 있습니다.

```dart
// Step 4에서 다룬 이벤트 처리를 활용해 보세요.
onTap: () {
  context.dispatchEvent(
    UserActionEvent(
      name: 'notHelpful',
      context: {'question': question},
    ),
  );
  // 이후 AI는 "죄송합니다. 다른 정보를 찾아드릴까요?"라며 자연스럽게 답변을 이어갑니다.
}
```

## 3. 디자인 시스템과의 결합
실제 서비스에서 GenUI 위젯은 브랜드 아이덴티티를 유지해야 합니다.
- **테마 준수**: `Theme.of(context).primaryColor` 등을 활용해 앱 전체의 테마 컬러와 위젯 컬러를 일치시킵니다.
- **애니메이션 추가**: `AnimatedContainer`나 `Implicit Animations`를 활용해 위젯이 등장할 때 부드러운 효과를 줄 수 있습니다.

## 4. 더 나아가기
이 코드랩을 마친 후 다음 프로젝트를 구상해 보세요:
- **이미지 생성**: `imageFixedSize` 카탈로그를 활용해 사용자의 문제 상황을 설명하는 이미지를 AI가 직접 생성하게 해보세요.
- **입력 양식 UI**: 단순한 텍스트 입력이 아닌, 날짜 선택기(DatePicker)나 슬라이더 같은 복잡한 입력을 AI가 직접 요청하고 렌더링하도록 확장할 수 있습니다.

---
## 마무리 🎉
120분간의 여정을 함께해 주셔서 감사합니다! 여러분은 이제 Gemini의 강력한 지능과 Flutter의 아름다운 UI를 결합해 **세상에 없던 대화형 경험**을 만들 수 있는 개발자가 되었습니다.

[인덱스로 돌아가기](./index.md)
