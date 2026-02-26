# 🧠 Mood Tracker

> Firebase 인증 + Firestore 연동 감정 기록 앱

Flutter 10주 스터디 졸업 과제

---

## 📌 프로젝트 소개

이메일 기반 회원가입/로그인 후, 오늘의 감정을 이모지와 텍스트로 기록하고 관리할 수 있는 앱입니다.  
MVVM 아키텍처와 Riverpod 상태관리를 적용하고,  
Firebase Authentication과 Firestore를 연동하여 사용자별 데이터를 관리합니다.

---

## 🛠️ 기술 스택

| 분류 | 기술 |
|:---|:---|
| **Language** | Dart |
| **Framework** | Flutter |
| **상태관리** | Riverpod (`AsyncNotifier`, `StateProvider`, `StreamProvider`) |
| **인증** | Firebase Authentication (이메일/비밀번호) |
| **데이터베이스** | Cloud Firestore (CRUD) |
| **라우팅** | GoRouter (인증 상태 기반 리다이렉트) |
| **패키지** | `intl` (날짜 포맷팅) |

---

## 🎯 핵심 기능 & 구현 상세

### 1. 인증 시스템 (`authentication/`)
- **회원가입:** 이메일 정규식 검증 + 비밀번호 8자 이상 유효성 검사, 비밀번호 표시/숨김 토글
- **로그인:** `Form` + `GlobalKey<FormState>` 기반 폼 검증
- **인증 상태 관리:** `StreamProvider`로 `authStateChanges()`를 구독하여 로그인 상태를 실시간 감지
- **라우트 가드:** `GoRouter`의 `redirect`에서 미로그인 시 자동으로 회원가입 화면으로 리다이렉트
- **로그아웃:** `CupertinoActionSheet`를 활용한 iOS 스타일 확인 모달

### 2. 감정 기록 작성 (`ArticleWriteScreen`)
- 8종 이모지(😀😍😊🤪😭🤬🥳🤮) 중 감정 선택 — 선택 시 Teal 색상 하이라이트
- 텍스트 입력 후 Firestore에 `mood`, `description`, `date`(밀리초 타임스탬프) 저장
- 저장 완료 시 `context.pushReplacement('/home')`으로 홈 화면 이동

### 3. 감정 기록 조회 (`ArticleShowScreen`)
- Firestore에서 전체 기록을 불러와 **최신순 정렬** (`b.date.compareTo(a.date)`)
- `intl` 패키지로 타임스탬프를 `yyyy년 MM월 dd일` 형식으로 변환
- 삭제 시 `AlertDialog`로 확인 후 Firestore 문서 삭제 + 목록 자동 갱신

### 4. 탭 네비게이션 (`TabnavigationMain`)
- `BottomNavigationBar`로 3개 탭 전환: 홈(기록 조회) / 작성 / 설정
- `BottomNavigationBarType.shifting` 애니메이션 적용

### 5. 설정 화면 (`UserScreen`)
- 알림 토글 (`SwitchListTile.adaptive`)
- 마케팅 수신 동의 (`CheckboxListTile`)
- 로그아웃, 앱 정보 (`AboutListTile`)

---

## 🏗️ 아키텍처 — MVVM + Riverpod
```
┌──────────────┐     ┌──────────────┐     ┌──────────────┐
│    View      │ ──→ │  ViewModel   │ ──→ │  Repository  │
│  (Screen/    │ ←── │  (AsyncNoti- │ ←── │  (Firebase   │
│   Widget)    │     │   fier)      │     │   Auth/DB)   │
└──────────────┘     └──────────────┘     └──────────────┘
```

| 레이어 | 역할 | 예시 |
|---|---|---|
| **View** | UI 렌더링, 사용자 입력 | `SignInScreen`, `ArticleWriteScreen` |
| **ViewModel** | 비즈니스 로직, 상태 관리 | `LoginViewModel`, `ArticleViewModel` |
| **Repository** | 외부 서비스 통신 | `AuthenticationRepo`, `ArticlesRepo` |

---

## 📂 프로젝트 구조
```
lib/
├── main.dart                              # 앱 진입점 (Firebase 초기화, ProviderScope)
├── router.dart                            # GoRouter 설정 (인증 기반 리다이렉트)
├── utils.dart                             # Firebase 에러 스낵바 유틸
├── firebase_options.dart                  # FlutterFire CLI 자동 생성
├── constants/
│   ├── gaps.dart                          # Sizes 상수 (1~96)
│   └── sizes.dart                         # Gaps 위젯 (SizedBox 프리셋)
└── features/
    ├── articles/
    │   ├── models/
    │   │   └── article_model.dart         # Article 모델 (mood, description, date)
    │   ├── repos/
    │   │   └── articles_repo.dart         # Firestore CRUD
    │   └── view_models/
    │       ├── article_view_model.dart    # 기록 조회/삭제 (AsyncNotifier)
    │       └── upload_article_view_model.dart  # 기록 업로드
    ├── authentication/
    │   ├── repos/
    │   │   └── authentication_repo.dart   # Firebase Auth (signUp/signIn/logOut)
    │   ├── view_models/
    │   │   ├── login_view_model.dart      # 로그인 로직
    │   │   └── signup_view_model.dart     # 회원가입 로직
    │   └── widgets/
    │       ├── form_button.dart           # AnimatedContainer 버튼
    │       ├── nickname_screen.dart       # 닉네임 화면 (Placeholder)
    │       ├── sign_in_screen.dart        # 로그인 화면
    │       └── sign_up_screen.dart        # 회원가입 화면
    └── tabNavigation/views/
        ├── tabNavigation_main.dart        # 탭 네비게이션 (홈/작성/설정)
        ├── article_show_screen.dart       # 감정 기록 리스트
        ├── article_write_screen.dart      # 감정 기록 작성
        └── settings_screen.dart           # 설정 (로그아웃)
```

---

## 🔐 인증 플로우
```
앱 시작
  │
  ├─ 로그인 상태 ──→ /home (탭 네비게이션)
  │
  └─ 미로그인 ──→ /sign_up (회원가입)
                    │
                    ├─ 회원가입 성공 ──→ /user (설정)
                    │
                    └─ "이미 계정이 있으신가요?" ──→ / (로그인)
                                                    │
                                                    └─ 로그인 성공 ──→ /user
```

---

## 📸 스크린샷

- 시연 영상 : https://imgur.com/a/Q59ZGKz
<div align="center">
  <img src="./web/screenshot signin.png" width="200" />
  <img src="./web/screenshot main.png" width="200" />
  <img src="./web/screenshot crud.png" width="200" />
  <img src="./web/screenshot setting.png" width="200" />
</div>

---

## 📝 배운 점

- **MVVM 아키텍처 설계** — View / ViewModel / Repository 레이어 분리를 통한 관심사 분리
- **Riverpod 상태관리** — `AsyncNotifier`로 비동기 상태 처리, `StreamProvider`로 인증 상태 실시간 구독
- **Firebase Authentication** — 이메일/비밀번호 인증 구현, `authStateChanges()` 스트림 활용
- **Cloud Firestore** — 문서 CRUD, `toJson`/`fromJson` 패턴을 통한 모델 직렬화
- **GoRouter** — 선언적 라우팅과 `redirect`를 활용한 인증 기반 라우트 가드 구현
- **Feature-based 폴더 구조** — 기능 단위로 모듈을 분리하여 확장성 있는 프로젝트 구조 설계

---

## 📎 관련 프로젝트

| 졸업 과제 | 설명 | 링크 |
|---|---|:---:|
| **Interactive Movie** | AnimationController 기반 인터랙티브 UI | [Repo](https://github.com/WAcAW9/2025_FlutterChallenge_Animation) |
| **Any Movie** | 외부 API 연동 영화 앱 | [Repo](https://github.com/WAcAW9/2025_FlutterChallenge_MovieApp) |
| **MoodTracker** | Firebase 인증 + DB 감정 기록 앱 (현재) | — |
