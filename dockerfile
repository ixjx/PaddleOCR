# Version: 2.3
FROM registry.baidubce.com/paddlepaddle/paddle:2.2.0

# PaddleOCR base on Python3.7
RUN pip3.7 install --upgrade pip -i https://pypi.tuna.tsinghua.edu.cn/simple
 
RUN pip3.7 install paddlehub --upgrade -i https://pypi.tuna.tsinghua.edu.cn/simple# 服务版与轻量版

RUN git clone https://github.com/ixjx/PaddleOCR.git /PaddleOCR
WORKDIR /PaddleOCR

RUN pip3.7 install -r requirements.txt -i https://pypi.tuna.tsinghua.edu.cn/simple
 
RUN mkdir -p /PaddleOCR/inference/

# 下载解压模型开始 ps:如果切换为服务端模型，记得修改deploy/hubserving/ocr_system/params.py下对应的模型位置
# ADD https://paddleocr.bj.bcebos.com/PP-OCRv2/chinese/ch_PP-OCRv2_det_infer.tar /PaddleOCR/inference/
# RUN tar xf /PaddleOCR/inference/ch_PP-OCRv2_det_infer.tar -C /PaddleOCR/inference/
ADD https://paddleocr.bj.bcebos.com/dygraph_v2.0/ch/ch_ppocr_server_v2.0_det_infer.tar /PaddleOCR/inference/
RUN tar xf /PaddleOCR/inference/ch_ppocr_server_v2.0_det_infer.tar -C /PaddleOCR/inference/

# ADD https://paddleocr.bj.bcebos.com/PP-OCRv2/chinese/ch_PP-OCRv2_rec_infer.tar /PaddleOCR/inference/
# RUN tar xf /PaddleOCR/inference/ch_PP-OCRv2_rec_infer.tar -C /PaddleOCR/inference/
ADD https://paddleocr.bj.bcebos.com/dygraph_v2.0/ch/ch_ppocr_server_v2.0_rec_infer.tar /PaddleOCR/inference/
RUN tar xf /PaddleOCR/inference/ch_ppocr_server_v2.0_rec_infer -C /PaddleOCR/inference/

ADD https://paddleocr.bj.bcebos.com/dygraph_v2.0/ch/ch_ppocr_mobile_v2.0_cls_infer.tar /PaddleOCR/inference/
RUN tar xf /PaddleOCR/inference/ch_ppocr_mobile_v2.0_cls_infer.tar -C /PaddleOCR/inference/
# 下载解压模型结束

EXPOSE 8868

CMD ["/bin/bash","-c","hub install deploy/hubserving/ocr_system/ && hub serving start -m ocr_system"]