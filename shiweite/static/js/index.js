var vm = new Vue({
    el: '#app',
    // 修改Vue变量的读取语法，避免和django模板语法冲突
    delimiters: ['[[', ']]'],
    data: {
        host,
        show_menu: false,
        is_login: true,
        username: ''
    },
    //vue做好了初始化工作，接着就需要开发人员来给他上面挂载数据，一般使用这个生命周期钩子函数，用来做页面数据初始化工作
    mounted() {
        //获取用户名信息
        //由于是中文，所以解析不了，该有后台解析后赋值
        this.username = getCookie('login_name');
        console.log(this.username)
        //获取是否登录信息
        this.is_login = getCookie('is_login');
    },
    methods: {
        //显示下拉菜单
        show_menu_click: function () {
            this.show_menu = !this.show_menu;
        }
    }
});
