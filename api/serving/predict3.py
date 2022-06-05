from google.cloud import automl
import os
import re
import tempfile
from flask import Flask, request, Response, render_template, jsonify
import json

os.environ["GOOGLE_APPLICATION_CREDENTIALS"] = "./argon-acolyte-335901-fbbd5e747c15.json"

# TODO(developer): Uncomment and set the following variables
project_id = "argon-acolyte-335901"
model_id = "TCN4252313941423685632"

app = Flask(__name__)


# @app.route("/")
# def root():
#     return render_template("ui.html")

@app.route("/api/dump", methods=['POST'])
def getDumpData():
    data = request.json
    print(data)
    with open("dump.txt","w", encoding='utf-8') as f:
        json.dump(data, f)
    
    return "Successfully sent", 200

# POST
@app.route("/predict", methods=['GET', 'POST'])
def predict():
    # txt에서 값 가져오기
    with open("./dump.txt", "r", encoding='utf-8') as file:
        dump = file.read()
    
    jsonData = json.loads(dump)
    
    for key in jsonData.keys():
            if key != 'created':
                thread = jsonData[key]
                stack = '\n'.join(thread['stack'])
                # file_st = open('dumps/threads/{0:07d}.txt'.format(idx), 'w')
                # idx = idx + 1
                # file_st.write(stack)
                # file_st.close()
                # thread의 이름에서 영어, 띄워쓰기만 남기고 나머지(숫자, 기호 등) 삭제 
                name = re.sub('[^ a-zA-Z]','',thread['name'])
                stack = re.sub('^\"[^\"]*\"', name, stack)
                
                #스레드의 고유번호(#1234), 포인터 저장 위치(형식 [0x000], <0x000>) 삭제
                stack = re.sub('#[0-9]+|\[[^)]*?\]|\<[^)]*?\>', '', stack)
                
                #공백, .(온점), (, ), ,(반점) 기준으로 split
                words = re.split(' |\.|\(|\)|\n|,', stack)
                
                dehydrated_words = []
                for word in words:
                    #비워있는 word 스킵
                    if word == '' : continue
                    
                    #java: 형식으로 되어있는 코드 행 삭제, prio=, os_prio, tid, nid 가 포함된 단어 삭제
                    #javax, at, java, com, org 처럼 의미없이 자주 출현하는 단어 삭제(불용어 처리)
                    if word.find('java:') == -1 and word.find('prio=') == -1 and word.find('id=') == -1 and \
                    word != 'javax' and word != 'at' and word != 'java' and word != 'com' and word != 'org':
                        dehydrated_words.append(word)

    content = ' '.join(dehydrated_words)
    print(dehydrated_words, flush=True)

    # autoML Service Client 불러오기
    prediction_client = automl.PredictionServiceClient()

    # Get the full path of the model.
    model_full_id = automl.AutoMlClient.model_path(project_id, "us-central1", model_id)

    # Supported mime_types: 'text/plain', 'text/html'
    # https://cloud.google.com/automl/docs/reference/rpc/google.cloud.automl.v1#textsnippet
    text_snippet = automl.TextSnippet(content=content, mime_type="text/plain")
    payload = automl.ExamplePayload(text_snippet=text_snippet)

    response = prediction_client.predict(name=model_full_id, payload=payload)
    
    result = []
    tmp = {}
    # 상위 10개 json으로 변환하여 반환
    for annotation_payload in response.payload[0:10]:
        result.append({'className' : annotation_payload.display_name, 'classScore' : annotation_payload.classification.score})
        # print(u"Predicted class name: {}".format(annotation_payload.display_name))
        # print(u"Predicted class score: {}".format(annotation_payload.classification.score))

    print(json.dumps(result))
    return json.dumps(result), 200


if __name__ == "__main__":
    app.run(host='0.0.0.0', port=9090)