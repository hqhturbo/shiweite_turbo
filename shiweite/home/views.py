from django.shortcuts import *
from django.views import View
from home.models import *
from django.core.paginator import Paginator,EmptyPage,PageNotAnInteger #导入django分页插件
import json
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
        # 5、根据分类信息查询该分类下的所有文章数据
        articles = Article.objects.filter(category=category)
        # 6、创建分页器
        pages = Paginator(articles,page_size) #对查询到的数据对象articles进行分页，设置超过指定页容量就分页
        try:
            list = pages.page(page_index) #获取当前页面的记录
        except PageNotAnInteger:
            list = pages.page(1) #如果用户输入的页面不是整数时，显示第1页的内容
        # 组织数据传递给模板

        hot_tags = Article.objects.values('tags').order_by('-total_views').distinct()[:9]
        # 2-3、最新文章
        new_arts = Article.objects.order_by('-create_time')[:3]
        new_a = Article.objects.order_by('-create_time')[:1]

        # if 'login_name' in request.COOKIES:
        #     login_name = request.COOKIES.get('login_name')
        #     username = json.loads(login_name)
        #     print('username',username)
        #     print('login_name',login_name)
        #     return username

        context = {
            'categories':categories,
            'category':category,
            'articles':list,
            'cat_id':cat_id,
            'hot_tags': hot_tags,
            'new_arts': new_arts,
            'new_a':new_a,
            # 'username':username
        }
        resp = render(request, 'index.html',context=context)
        resp.set_cookie('cat_id',cat_id)
        return resp

# 详情视图
class DetailView(View):
    def get(self,req):
        # 1、获取文章id
        art_id = req.GET.get('art_id')
        categories = ArticleCategory.objects.all()
        # 2、根据文章id查询文章信息
        try:
            art = Article.objects.get(id=art_id)
        except Article.DoesNotExist:
            return render(req, '404.html',{
                'context':'您访问的文章不存在'
            })
        # 2-1、浏览量的简单做法：只要被查询一次，那么就算一次访问
        art.total_views += 1
        art.save()
        # 2-2、重新查询文章信息，按照浏览量降序排序（热门标签）
        hot_tags = Article.objects.values('tags').order_by('-total_views').distinct()[:9]
        # 2-3、最新文章
        new_arts = Article.objects.order_by('-create_time')[:3]
        # 2-4、获取所有评论信息
        comm = Comment.objects.filter(article=art).order_by('-created_time')
        # 3、返回页面
        context = {
            'categories':categories,
            'article': art,
            'hot_tags': hot_tags,
            'new_arts': new_arts,
            'comms':comm
        }
        return render(req,'details.html',context=context)
    def post(self,req):
        # 1、获取已登录用户信息
        user = req.user
        # 2、判断用户是否登录
        if user and user.is_authenticated:
            # 3、登录用户才可以接受form数据
            # 3-1、接受评论数据
            art_id = req.POST.get('art_id')
            content = req.POST.get('content')
            # 3-2、验证文章是否存在
            try:
                art = Article.objects.get(id=art_id)
            except Article.DoesNotExist:
                return render(req, '404.html', {
                    'context': '您访问的文章不存在'
                })
            # 3-3、保存评论数据
            Comment.objects.create(content=content,article=art,user=user)
            # 3-4、修改评论数量
            art.comments_count += 1
            art.save()
            # 刷新当前页面
            req_url = req.path + '?art_id=' + art_id
            return redirect(req_url)
        else:
            # 4、未登录用户则跳转到登录页面
            return redirect(reverse('users:login'))