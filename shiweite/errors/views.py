from django.shortcuts import render

# Create your views here.

def page_not_found404(request, exception):
    return render(request,'404.html')

def page_not_found500(request):
    return render(request,'500.html')