from django.shortcuts import *
from django.views import View
from home.models import *

# Create your views here.
# 主页
class IndexView(View):
    def get(self, request):
        # 1、获取所有分类信息数据
        categories = ArticleCategory.objects.all()
        # 2、接受用户点击的分类id
        cat_id = request.GET.get('cat_id',1)
        # 3、根据分类id进行分类的查询
        try:
            category = ArticleCategory.objects.filter(id = cat_id).first()
        except ArticleCategory.DoesNotExist:
            return HttpResponseRedirect('此分类信息不存在')
        # 4、获取分页参数
        page_index = request.GET.get('page_index',1) #页码
        page_size = request.GET.get('page_size',2) #页容量
        # 5、根据分页信息查询该分类下的所有文章数据
        articles = Article.objects.filter(category=category)
        # 6、创建分页器
        from django.core.paginator import Paginator,EmptyPage,PageNotAnInteger #导入django分页插件
        pages = Paginator(articles,page_size) #对查询到的数据对象articles进行分页，设置超过指定页容量就分页
        try:
            list = pages.page(page_index) #获取当前页面的记录
        except PageNotAnInteger:
            list = pages.page(1) #如果用户输入的页面不是整数时，显示第1页的内容
        # 组织数据传递给模板
        context = {
            'categories':categories,
            'category':category,
            'articles':list,
            'cat_id':cat_id
        }
        print(list)
        return render(request, 'index.html',context=context)
