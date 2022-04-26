# -*- coding:utf-8 -*-
from __future__ import absolute_import
from __future__ import division
from __future__ import print_function


class Config(object):
    pass


def read_params():
    cfg = Config()

    #params for text recognizer
    cfg.rec_algorithm = "CRNN"
    cfg.rec_model_dir = "./inference/ch_ppocr_server_v2.0_rec_infer/"  #模型路径

    cfg.rec_image_shape = "3, 32, 320"
    cfg.rec_char_type = 'ch'
    cfg.rec_batch_num = 30
    cfg.max_text_length = 25

    cfg.rec_char_dict_path = "./ppocr/utils/ppocr_keys_v1.txt"   #字典路径
    cfg.use_space_char = False   #是否识别空格

    cfg.use_pdserving = False
    cfg.use_tensorrt = False

    return cfg
