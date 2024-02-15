# server_fastapi_vgg16.py
import uvicorn   # uvicorn 라이브러리 임포트
from fastapi import FastAPI   # FastAPI 라이브러리 임포트
from fastapi.middleware.cors import CORSMiddleware # CORS 문제 해결을 위한 미들웨어

# 예측 모듈 가져오기
import densenet121_prediction_model

# FastAPI 애플리케이션 생성
app = FastAPI()

# CORS 이슈 해결을 위한 설정
origins = ["*"]

app.add_middleware(
    CORSMiddleware,
    allow_origins=origins,
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

# 루트 엔드포인트에 대한 간단한 GET 요청 처리
@app.get("/")
async def read_root():
    print("URL이 요청되었습니다.")
    return "Densenet121 모델을 사용하는 API를 만들어 봅시다."

# '/sample' 엔드포인트에 대한 GET 요청 처리
@app.get('/sample')
async def sample_prediction():
    result = await densenet121_prediction_model.prediction_model()
    print("예측이 요청되고 완료되었습니다.")
    return result

# 서버 실행
if __name__ == "__main__":
    uvicorn.run("server_fastapi_dense121:app",
            reload= True,   # 코드 변경 시 서버 재시작
            host="127.0.0.1",   # localhost에서 실행
            port=5000,   # 포트 5000에서 실행
            log_level="info"   # 로그 레벨 설정
            )