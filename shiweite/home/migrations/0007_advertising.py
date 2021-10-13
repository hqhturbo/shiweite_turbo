# Generated by Django 2.2 on 2021-10-12 17:30

from django.db import migrations, models
import django.utils.timezone


class Migration(migrations.Migration):

    dependencies = [
        ('home', '0006_auto_20211013_0126'),
    ]

    operations = [
        migrations.CreateModel(
            name='Advertising',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('title', models.CharField(blank=True, max_length=100)),
                ('advertis', models.ImageField(blank=True, upload_to='advertis/%Y%m%d/')),
                ('create_time', models.DateTimeField(default=django.utils.timezone.now)),
            ],
            options={
                'verbose_name': '广告管理',
                'verbose_name_plural': '广告管理',
                'db_table': 'tb_advertising',
            },
        ),
    ]