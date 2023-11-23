#각자정리

[[지도학습]] - XGBoost
# 파라미터
- booster(기본값 gbtree) : 부스팅 알고리즘 (또는 dart, gblinear)
- objective(기본값 binary : logistic) : 이진분류 (다중분류 : multi : softmax)
- max_depth(기본값 6) : 최대 한도 깊이
- learning_rate(기본값 0.1) : 학습률
- n_estimators(기본값 100) : 트리의 수
- subsample(기본값 1) : 훈련 샘플개수의 비율
- colsample_bytree(기본값 1) : 특성 개수의 비율
- n_jobs(기본값 1) : 사용 코어 수(-1 : 모든 코어를 다 사용)
## General Parameters
- booster
    - 기본값 : gbtree
    - 어떤 부스터를 쓸지 고른다. [gbtree, gblinear, dart] 중 하나
- verbosity
    - 기본값 : 1
    - 출력 메시지 레벨
    - [0 (silent), 1 (warning), 2 (info), 3 (debug)] 중 하나
- validate_parameters
    - 기본값 : false
    - 파라미터 유효성 검사
    - 설정. 여러 파라미터들을 설정하다 보면 서로 모순되는 값들을 넣는 실수를 하는 실수를 방지해준다.
    - 아직 실험단계이다. 파이썬에선 지원되지 않기 때문에 나는 사용해본 적 없음.
- nthread
    - 기본값 : 최대
    - 학습에 사용할 thread수.
    - ML전용 컴퓨터를 사용하기 때문에 따로 건드린 적 없이 기본값으로 최대만 사용해보았음.
- disable_default_eval_metric
    - 기본값 : 0
    - 0이면 기본 metric 사용, 아니면 기본 metric을 사용하지 않는다.
    - 커스텀 metric을 사용할 경우 설정한다.
- num_pbuffer
    - 기본값 : 자동으로 설정
    - 마지막 부스팅 단계의 예측 결과를 저장하는 버퍼의 크기
    - 자동으로 설정되기에 건드린 적 없음.
- num_feature
    - 기본값 : 인풋 피쳐의 수와 동일하게 설정됨
    - 부스팅에 사용되는 피쳐 수.
    - 자동으로 설정되기에 건드린 적 없음.
- 
## Tree booster Parameters
- eta [alias: learning_rate]
    - 기본값 : 0.3 / 범위 : [0,1] 
    - 학습률. 낮은 값일수록 모델이 견고해지고 오버 피팅 방지에 좋다.
    - 일반적으로 0.01 ~ 0.3 정도로 설정하는데, 제한된 리소스를 가진 기계에 모델을 올려야 할 경우 Step 수를 줄이기 위해 0.9까지 올려 모델 크기를 최소화한 적도 있다. 일반적인 상황이라면 권장하지 않는다.
- gamma [alias: min_split_loss]
    - 기본값 : 0 / 범위 : [0,∞]
    - gain 값이 gamma 이상일 경우 자식 노드를 생성하도록 한다.
    - Overfitting 방지에 좋으나 너무 높으면 underfitting 이 생길 수가 있음.
    - lambda, alpha 값에도 영향을 받기 때문에, 파라미터 튜닝 시 세 가지를 동시에 바꿔가며 grid search를 하는 편
- max_depth
    - 기본값 : 6 / 범위 : [0,∞]
    - 최대 트리의 깊이. N이라고 가정하면 2^N개의 리프 노드가 생긴다. 10일 때 최대 1024개의 리프 노트가 생긴다.
    - 일반적으로 Feature 수에 따라 3~6으로 세팅한 후 성능이 증가하고, 오버 피팅이 나지 않을 때까지 늘려간다.
    - 제한된 리소스에 모델을 올려야 할 경우 울며 겨자 먹기로 약간의 성능을 포기하고 depth를 줄이기도 한다.
- subsample
    - 기본값 : 1 범위: (0,1]
    - 각각의 스탭마다 사용할 샘플의 비율. 1 이하의 값을 사용하면 오버 피팅을 방지할 수 있다.
    - 개인적으로 cross validation을 주로 쓴다면 크게 중요한 파라미터가 아닌 것 같다.
- sampling_method
    - 기본값 : uniform
    - subsample을 1 이하로 설정한다면 샘플을 뽑는지 정의한다.
    - [uniform, gradient_based] 중 하나

> subsample은 data자
> 
> 체를 샘플링하는 것이고 colsample_* 파라미터는 feature를 샘플링하는 것이다.  
> colsample_* 파라미터는 feature가 너무 많거나 소수의 feature에 지나치게 의존적일 때 사용하면 좋음.

- colsample_bytree
    - 기본값 : 1 / 범위 : (0,1]
    - 각각의 트리(스탭)마다 사용할 칼럼(Feature)의 비율
    - 개인적으로 colsample_* 파라미터 둘 중에 가장 효과가 좋은 것 같음.
- colsample_bylevel
    - 기본값 : 1 / 범위 : (0,1]
    - 각각의 트리 depth 마다 사용할 칼럼(Feature)의 비율
- colsample_bynode
    - 기본값 : 1 / 범위 : (0,1]
    - 각각의 노드 depth 마다 사용할 칼럼(Feature)의 비율
    - colsample_bylevel와 비슷해 보이지만 이 경우 좌, 우 리프 노드가 서로 다른 feature를 사용하게 된다.

- lambda [alias: reg_lambda]
    - 기본값 : 1 / 범위 : [0,∞]
    - L2 정규화(규제) 파라미터이다.
    - 커질수록 보수적인 모델을 생성하고 오버 피팅을 방지해준다. 지나치게 클 경우 언더 피팅이 난다. 
    - 너무 큰 가중치를 그 크기에 비례하여 줄여준다.
    - noise나 outlier 같은 애들이나 너무 크게 튀는 데이터들을 어느 정도 잡아준다고 보면 된다. 
    - gamma, alpha와 함께 튜닝함.
- alpha [alias: reg_alpha]
    - 기본값 : 0 / 범위: [0,∞]
    - L1 정규화(규제) 파라미터이다.
    - 커질수록 보수적인 모델을 생성하고 오버 피팅을 방지해준다.
    - 불필요한 가중치를 0으로 만들어서 무시하도록 한다. 
    - sparse feature 가 있거나 feature수가 지나치게 많을 때 효과적이다.
    - gamma, lambda와 함께 튜닝함.
- scale_pos_weight
    - [default=1]
    - 데이터 클래스(레이블) 불균형이 있을 때 레이블 가중치를 조절해주는 파라미터
    - 권장 값 : sum(negative instances) / sum(positive instances)
    - 왜 끝에 설명하는지 모르겠지만 굉장히 중요한 파라미터. 데이터 불균형이 심한 경우 꼭 설정해주는 게 좋다.
## Learning Task Parameters
학습 목표에 관련된 파라미터는 다음과 같다.

- objective
    - 기본값 : reg:squarederror
    - 목적함수이다. 이 함수를 통해 나온 값이 최소화되는 방향으로 학습된다.
    - 종류가 너무 다양해 자주 쓰는 것들만 설명하자면
        - reg:squarederror / reg:squaredlogerror : 오차 제곱 / 오차 로그 제곱
        - binary:logistic : 이항 분류(binary class)에 사용. 이항 분류는 대부분 이놈만 쓴다.
        - multi:softmax / multi:softprob : 다항 분류(multi class)에 사용.
        - rank:pairwise / rank:ndcg / rank:map : l2r에 사용
- base_score
    - 기본값 : 0.5
    - 초기 편향치(bias)이다.
    - 범위가 0~1 사이가 아닌 값을 예측하는 경우 이 값을 그 중간 값으로 설정해주면 가끔 성능이 좋아지거나 빨리 종료되기도 한다.
- eval_metric
    - 기본값 : objective에 따라 다름.
    - 평가 지표이다. 각 스텝마다 완성된 모델을 이 지표를 통해서 평가한다.
    - 이것도 너무 많으므로 자주 쓴 것들만 설명.
        - rmse / rmsle : 글자 그대로 역순으로 해석하면 된다. 에러 (로그) 제곱 평균의 루트 값
        - mae : 오차 절댓값 평균
        - error / error@t : 이항 분류(binary class)에서 error는 0.5 이상을 1 미만을 0이라고 판단하고 error@t는 t 이상을 1 미만을 0이라고 판단한다.
        - merror : error의 다항 분류(multi class) 버전
        - auc : auc는 area under curve의 약자로 즉 곡선 아래의 면적 이란 뜻이다. 보통 auc라고 하면 roc auc을 뜻한다. FPR과 TPR에 민감한 데이터 셋 일 경우 사용한다.
        - aucpr : auc뒤에 붙은 pr은 preicison recall을 뜻한다. f-score나 precision, recall에 민감할 때 사용한다.(error나 rmse가 더 잘 나오는 경우도 많으니 다 해봐야 함.)
- seed
    - 기본값 : 0
    - 랜덤 시드이다. 같은 데이터 셋으로 여러 모델을 비교할 때는 같은 값으로 설정하고 비교해야 한다.
## 기타
- num_boost_round
    - 기본값 : 의무 설정 / 범위: [0,∞]
    - 몇 회의 step을 반복할지 지정한다. 너무 높은 값을 사용하면 오버 피팅이 생기고 모델의 사이즈가 커진다.
- early_stopping_rounds
    - 기본값 : 설정하지 않을 경우 비활성화. / 범위: [0,∞]
    - 조기 종료 조건이다.
    - eval_metric이 결과가 early_stopping_rounds 횟수 동안 개선되지 않으면 num_boost_round에 도달하기 전에 종료한다.
# 특징
- 부스팅(앙상블) 기반의 알고리즘
- Extreme Gradient Boosting의 약자, 변화도(경사도) 부스팅
- 캐글(글로벌 AI 경진대회)에서 뛰어난 성능을 보이면서 인기가 높아짐
## XGBoost Graph
![](https://i.imgur.com/PBE0jWy.png)


# 장점과 단점
장점
- GBM(Greadient Boosting Model)대비 빠른 수행시간
- 병렬 처리로 학습, 분류 속도가 빠르다.
- 과적합 규제
- 분류와 회귀 영역에서 뛰어난 예측 성능 발휘
- Early Stopping (조기 종료) 기능이 있음
- 다양한 옵션을 제공하며 Customizing이 용이하다.
- 결측치를 내부적으로 처리해준다.
- 자체 내장된 교차 검증
단점
- 매개변수 튜닝이 어렵다.
- 많은 메모리와 프로세싱 파워를 요구한다.
- 해석이 어렵다.
