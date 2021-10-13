# Generated by Django 2.2 on 2021-10-12 17:25

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('home', '0004_comment'),
    ]

    operations = [
        migrations.AlterModelOptions(
            name='articlecategory',
            options={'verbose_name': '广告管理', 'verbose_name_plural': '广告管理'},
        ),
        migrations.AddField(
            model_name='articlecategory',
            name='advertis',
            field=models.ImageField(blank=True, upload_to='advertis/%Y%m%d/'),
        ),
        migrations.AlterModelTable(
            name='articlecategory',
            table='advertising',
        ),
    ]
