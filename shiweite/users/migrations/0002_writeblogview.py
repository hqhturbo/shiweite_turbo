# Generated by Django 2.2 on 2021-09-30 08:18

from django.db import migrations, models
import django.db.models.deletion
import django.views.generic.base


class Migration(migrations.Migration):

    dependencies = [
        ('home', '0002_article'),
        ('users', '0001_initial'),
    ]

    operations = [
        migrations.CreateModel(
            name='WriteBlogView',
            fields=[
                ('articlecategory_ptr', models.OneToOneField(auto_created=True, on_delete=django.db.models.deletion.CASCADE, parent_link=True, primary_key=True, serialize=False, to='home.ArticleCategory')),
            ],
            bases=('home.articlecategory', django.views.generic.base.View),
        ),
    ]