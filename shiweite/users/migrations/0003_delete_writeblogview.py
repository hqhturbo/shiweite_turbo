# Generated by Django 2.2 on 2021-09-30 09:15

from django.db import migrations


class Migration(migrations.Migration):

    dependencies = [
        ('home', '0003_auto_20210930_1715'),
        ('users', '0002_writeblogview'),
    ]

    operations = [
        migrations.DeleteModel(
            name='WriteBlogView',
        ),
    ]
