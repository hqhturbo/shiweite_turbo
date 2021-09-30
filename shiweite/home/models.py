from django.db import models
from django.utils import timezone
from users.models import User


# Create your models here.

# 文章分类

class ArticleCategory(models.Model):
    # 文章标题
    title = models.CharField(max_length=100, blank=True)
    # 创建时间
    create_time = models.DateTimeField(default=timezone.now)

    # admin站点显示，方便调试查看对象
    def __str__(self):
        return self.title

    # 配置生成表参数
    class Meta:
        db_table = 'tb_category'  # 指定生成表明
        verbose_name = '类别管理'  # admin站点显示
        verbose_name_plural = verbose_name


class Article(models.Model):
    # 作者
    # 参数on_delete就是当user表中的数据删除之后，文章信息也同步删除
    author = models.ForeignKey(User, on_delete=models.CASCADE, verbose_name='作者')
    # 标题图
    avatar = models.ImageField(upload_to='article/%Y/%m/%d/', blank=True, verbose_name='标题图')
    # 标题
    title = models.CharField(max_length=100, blank=False, verbose_name='标题')
    # 分类
    # 参数表示这个字段可以为空null=Ture；blank=Ture 表示不是必填项
    category = models.ForeignKey(ArticleCategory, null=True, blank=True, on_delete=models.CASCADE, verbose_name='分类')
    # 标签
    tags = models.CharField(max_length=20, blank=True)
    # 摘要信息
    sumary = models.CharField(max_length=200, null=False, blank=False)
    # 文章正文
    content = models.TextField()
    # 浏览量
    total_views = models.PositiveIntegerField(default=0)
    # 评论量
    comments_count = models.PositiveIntegerField(default=0)
    # 文章创建时间
    create_time = models.DateTimeField(default=timezone.now)
    # 文章修改时间
    update_time = models.DateTimeField(auto_now=True)

    # 方便输出调试信息
    def __str__(self):
        return self.title

    # 修改表名以及admin展示的配置信息等
    class Meta:
        db_table = 'tb_article'
        ordering = ('-create_time',)
        verbose_name = '文章管理'
        verbose_name_plural = verbose_name

class Comment(models.Model):
    # 评论内容
    content = models.TextField()
    # 评论的文章
    article = models.ForeignKey(Article,on_delete=models.SET_NULL,null=True)
    #评论的用户
    user = models.ForeignKey(User,on_delete=models.SET_NULL,null=True)
    # 评论的时间
    created_time = models.DateTimeField(auto_now_add=True)

    # 方便输出调试信息
    def __str__(self):
        return self.article.title

    # 修改表名以及admin展示的配置信息等
    class Meta:
        db_table = 'tb_comment'
        verbose_name = '评论管理'
        verbose_name_plural=verbose_name