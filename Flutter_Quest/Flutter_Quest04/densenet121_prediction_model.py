# 예측에 필요한 라이브러리 임포트
import tensorflow as tf
from PIL import Image
import numpy as np
import matplotlib.pyplot as plt
from tensorflow.keras.preprocessing import image
from tensorflow.keras.applications.imagenet_utils import decode_predictions

async def prediction_model():
    label = {0 :'Moon_jellyfish',
        1 : 'mauve_stinger_jellyfish',
        2: 'lions_mane_jellyfish',
        3: 'compass_jellyfish',
        4: 'blue_jellyfish',
        5: 'barrel_jellyfish'}
    
    # 모델 불러오기
    model = tf.keras.models.load_model('./model-best.h5')
    
    # 이미지 불러오기
    img = Image.open('./images/jellyfish.jpg')
    
    # 이미지 크기 조정
    target_size = 224
    img = img.resize((target_size, target_size)) 

    # numpy 배열로 변환
    np_img = image.img_to_array(img)

    # 4차원으로 변경하여 배치 차원 추가
    img_batch = np.expand_dims(np_img, axis=0)

    # 특성 정규화
    pre_processed = img_batch / 255.0
    
    # 모델을 사용하여 예측
    y_preds = model.predict(pre_processed)
    np.set_printoptions(suppress=True, precision=5) # 소수점 5자리까지 표시
    # 1위 예측 반환
    result = {"predicted_label" : str(label[np.argmax(y_preds)]), "prediction_score" : str(y_preds[0][np.argmax(y_preds)])}
    return result
    