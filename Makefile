# ============================================================
#  daq-kafka-dashboard  Makefile
#
#  수정 가능한 파일:  assets/config.json
#  사용법:
#    make apk       - Docker로 APK 빌드 (결과: dist/app-release.apk)
#    make apk-local - 로컬 Flutter 환경으로 APK 빌드
#    make install   - 연결된 Android 기기에 APK 설치
#    make clean     - 빌드 산출물 정리
#    make help      - 도움말
# ============================================================

.PHONY: all apk apk-local install clean help

APP_NAME    := daq-dashboard
BUILD_IMAGE := $(APP_NAME)-builder
APK_SRC     := build/app/outputs/flutter-apk/app-release.apk
APK_DIST    := dist/app-release.apk

all: help

# ── Docker 빌드 (Flutter 환경 없어도 됨) ─────────────────────
apk:
	@echo "[daq-kafka-dashboard] Building APK via Docker..."
	@mkdir -p dist
	docker build -t $(BUILD_IMAGE) -f deploy/Dockerfile .
	docker create --name $(BUILD_IMAGE)-tmp $(BUILD_IMAGE)
	docker cp $(BUILD_IMAGE)-tmp:/app/$(APK_SRC) $(APK_DIST)
	docker rm $(BUILD_IMAGE)-tmp
	@echo "[daq-kafka-dashboard] APK saved to $(APK_DIST)"

# ── 로컬 Flutter 빌드 (flutter 설치된 환경) ──────────────────
apk-local:
	@echo "[daq-kafka-dashboard] Building APK locally..."
	@mkdir -p dist
	flutter pub get
	flutter build apk --release --target-platform=android-arm64
	cp $(APK_SRC) $(APK_DIST)
	@echo "[daq-kafka-dashboard] APK saved to $(APK_DIST)"

# ── 기기에 설치 ───────────────────────────────────────────────
install:
	@if [ ! -f $(APK_DIST) ]; then \
	  echo "[ERROR] APK not found. Run 'make apk' or 'make apk-local' first."; \
	  exit 1; \
	fi
	@echo "[daq-kafka-dashboard] Installing to connected Android device..."
	adb install -r $(APK_DIST)
	@echo "[daq-kafka-dashboard] Install complete."

# ── 정리 ──────────────────────────────────────────────────────
clean:
	@echo "[daq-kafka-dashboard] Cleaning build artifacts..."
	@rm -rf build dist
	@docker rmi $(BUILD_IMAGE) 2>/dev/null || true
	@echo "[daq-kafka-dashboard] Clean complete."

# ── 도움말 ────────────────────────────────────────────────────
help:
	@echo ""
	@echo "  daq-kafka-dashboard  빌드 도구"
	@echo "  ================================"
	@echo "  설정 파일: assets/config.json"
	@echo "            (server_address, port 수정)"
	@echo ""
	@echo "  make apk        Docker로 APK 빌드 (Flutter 불필요)"
	@echo "  make apk-local  로컬 Flutter로 APK 빌드"
	@echo "  make install    연결된 Android 기기에 APK 설치"
	@echo "  make clean      빌드 산출물 정리"
	@echo ""
	@echo "  결과물: dist/app-release.apk"
	@echo ""
