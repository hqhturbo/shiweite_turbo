"""
# -*- coding: utf-8 -*-
-------------------------------------------------
# @Project  :shiweite
# @File     :common_pro.py
# @Date     :2021/10/13 10:34
# @Author   :turbo
# @Email    :2647387166
# @Software :PyCharm
-------------------------------------------------
"""
from home.views import *
import json
def common_data(request):
    # select
    # DISTINCT
    # tb_article.tags, tb_article.total_views
    # from tb_article ORDER
    # BY
    # tb_article.total_views
    # DESC
    # LIMIT
    # 9
    hot_tags = Article.objects.values('tags').order_by('-total_views').distinct()[:9]
    # 2-3、最新文章
    new_arts = Article.objects.order_by('-create_time')[:3]
    one_arts = []
    for n in new_arts:
        one_arts.append(n.id)
    one_arts.sort()
    arts_max = one_arts[len(one_arts) - 1]
    if 'login_name' in request.COOKIES:
        username = request.COOKIES.get('login_name')
        username = json.loads(username)
    else:
        username=''
    return {
        'hot_tags': hot_tags,
        'new_arts': new_arts,
        'arts_max': arts_max,
        'username':username
    }