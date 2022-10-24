import cv2
import base64
import numpy as np
from deepface import DeepFace

def get_emotion(img_base64):
    #バイナリデータ <- base64でエンコードされたデータ  
    img_binary = base64.b64decode(img_base64)
    jpg=np.frombuffer(img_binary,dtype=np.uint8)

    #raw image <- jpg
    img = cv2.imdecode(jpg, flags=cv2.IMREAD_COLOR)
    result = DeepFace.analyze(img,actions=['emotion'])

    return result

# if __name__ == '__main__':
#     get_emotion.run()