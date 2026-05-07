# daq-kafka-dashboard

DAQ Tablet Dashboard
cam0/1/2 + GNSS 모니터링 및 수집 제어 Android 앱

---

## 배포 구성

```
Tablet (Android)
└── daq-kafka-dashboard APK
        ↕ gRPC :50050
    Edge Server (daq-kafka-producer)
```

---

## 시작하기

### 1. 설정 파일 수정

assets/config.json

| 항목 | 설명 |
|------|------|
| server_address | edge server IP |
| port | daq-gateway gRPC 포트 (기본 50050) |

### 2. APK 빌드

Docker 환경 (Flutter 설치 불필요)
```bash
make apk
```

로컬 Flutter 환경
```bash
make apk-local
```

결과물: dist/app-release.apk

### 3. 기기에 설치

```bash
make install
```

또는 dist/app-release.apk 를 태블릿에 직접 전송 후 설치

---

## 앱 기능

- cam0 / cam1 / cam2 라이브 스냅샷
- GNSS (위도/경도/고도) 실시간 표시
- 수집 시작 / 수집 정지 제어
- 센서 연결 상태 / 헬스 체크
