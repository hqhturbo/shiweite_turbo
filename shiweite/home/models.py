from django.db import models
from django.utils import timezone
# Create your models here.

# 文章分类

class ArticleCategory(models.Model):
    # 文章标题
    title = models.CharField(max_length=100,blank=True)
    # 创建时间
    create_time = models.DateTimeField(default=timezone.now)

    # admin站点显示，方便调试查看对象
    def __str__(self):
        return self.title

    # 配置生成表参数
    class Meta:
        db_table = 'tb_category'  #指定生成表明
        verbose_name = '类别管理'  #admin站点显示
        verbose_name_plural = verbose_name