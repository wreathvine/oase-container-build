# Copyright 2019 NEC Corporation
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#
"""
[概要]
指定の値に基づき初期レコードを更新するコマンド for Docker版
"""

import traceback

from django.core.management.base import BaseCommand

from django.conf import settings
from web_app.models.models import System
from libs.commonlibs.aes_cipher import AESCipher


cipher = AESCipher(settings.AES_KEY)


class Command(BaseCommand):
    """
    指定の値に基づき初期レコードを更新するコマンド
    主な用途として、Docker版OASEの環境変数に設定された値をDBに保存する目的
    """

    help = '指定の値に基づき初期レコードを更新するコマンド'

    def add_arguments(self, parser):

        parser.add_argument('values', nargs='+', type=str, help='id value')


    def handle(self, *args, **options):

        values = options['values']
        if len(values) < 3:
            print('[ERROR] 引数が不正です。 引数は3個必要です。')
            return

        id  = int(values[0])
        val = values[1]
        enc_flg = True if int(values[2]) > 0 else False

        modify(id, val, enc_flg)


def modify(id, val, enc_flg):

    try:
        if enc_flg:
            val = cipher.encrypt(val)

        System.objects.filter(item_id=id).update(value=val)

    except Exception as e:
        print(traceback.format_exc())

