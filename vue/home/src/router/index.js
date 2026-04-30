import Vue from 'vue';
import VueRouter from 'vue-router';
import index from '../views/index.vue'
import login from '../views/account/login.vue';
Vue.use(VueRouter)

const routes = [
	// 主页
	{
		path: '/',
		name: 'index',
		component: index
	},
	// 登录
	{
		path: '/account/login',
		name: 'login',
		component: login
	},
	// 忘记密码
	{
		path: '/account/forgot',
		name: 'forgot',
		component: () => import('../views/account/forgot.vue')
	},
	// 注册账号
	{
		path: '/account/register',
		name: 'register',
		component: () => import('../views/account/register.vue')
	},
	// 媒体图片
	{
		path: '/media/image',
		name: 'media_image',
		component: () => import('../views/media/image.vue')
	},

	// 音乐
	// {
	// 	path: '/media/music',
	// 	name: 'media_music',
	// 	component: () => import('../views/media/music.vue')
	// },
	// 媒体视频
	{
		path: '/media/video',
		name: 'media_video',
		component: () => import('../views/media/video.vue')
	},
	// 媒体视频
	{
		path: '/user_center/index',
		name: 'user_center_index',
		component: () => import('../views/user_center/index.vue')
	},
	// 文章路由
	{
		path: '/article/list',
		name: 'article_list',
		component: () => import('../views/article/list.vue')
	},
	{
		path: '/article/details',
		name: 'article_details',
		component: () => import('../views/article/details.vue')
	},
	// 浏览网站
	// 收藏路由
	{
		path: '/user/collect',
		name: 'collect_list',
		component: () => import('../views/user/collect.vue')
	},


	{
		path: '/comment/table',
		name: 'comment_table',
		component: () => import('../views/comment/table.vue')
	},
	{
		path: '/comment/view',
		name: 'comment_view',
		component: () => import('../views/comment/view.vue')
	},





	// 公告路由
	{
		path: '/notice/list',
		name: 'notice_list',
		component: () => import('../views/notice/list.vue')
	},
	{
		path: '/notice/details',
		name: 'notice_details',
		component: () => import('../views/notice/details.vue')
	},






	// 商品信息表格路由
	{
		path: '/merchandise_information/table',
		name: '/merchandise_information_table',
		component: () => import('../views/merchandise_information/table.vue')
	},
	// 商品信息详情路由
	{
		path: '/merchandise_information/view',
		name: '/merchandise_information_view',
		component: () => import('../views/merchandise_information/view.vue')
	},

	// 商品信息列表路由
	{
		path: '/merchandise_information/list',
		name: '/merchandise_information_list',
		component: () => import('../views/merchandise_information/list.vue')
	},

	// 商品信息详情路由
	{
		path: '/merchandise_information/details',
		name: '/merchandise_information_details',
		component: () => import('../views/merchandise_information/details.vue')
	},



	// 销售信息表格路由
	{
		path: '/sales_information/table',
		name: '/sales_information_table',
		component: () => import('../views/sales_information/table.vue')
	},
	// 销售信息详情路由
	{
		path: '/sales_information/view',
		name: '/sales_information_view',
		component: () => import('../views/sales_information/view.vue')
	},
	// 销售信息添加路由
	{
		path: '/sales_information/edit',
		name: '/sales_information_edit',
		component: () => import('../views/sales_information/edit.vue')
	},





	// 供应信息表格路由
	{
		path: '/supply_information/table',
		name: '/supply_information_table',
		component: () => import('../views/supply_information/table.vue')
	},
	// 供应信息详情路由
	{
		path: '/supply_information/view',
		name: '/supply_information_view',
		component: () => import('../views/supply_information/view.vue')
	},





	// 采购信息表格路由
	{
		path: '/purchasing_information/table',
		name: '/purchasing_information_table',
		component: () => import('../views/purchasing_information/table.vue')
	},
	// 采购信息详情路由
	{
		path: '/purchasing_information/view',
		name: '/purchasing_information_view',
		component: () => import('../views/purchasing_information/view.vue')
	},





	// 库存信息表格路由
	{
		path: '/inventory_information/table',
		name: '/inventory_information_table',
		component: () => import('../views/inventory_information/table.vue')
	},
	// 库存信息详情路由
	{
		path: '/inventory_information/view',
		name: '/inventory_information_view',
		component: () => import('../views/inventory_information/view.vue')
	},






	// 用户路由
	{
		path: '/user/index',
		name: 'user_index',
		component: () => import('../views/user/index.vue')
	},
	// 基本信息
	{
		path: '/user/info',
		name: 'user_info',
		component: () => import('../views/user/info.vue')
	},
	// 找回密码
	{
		path: '/user/password',
		name: 'user_password',
		component: () => import('../views/user/password.vue')
	},

	// 搜索
	{
		path: '/search',
		name: 'search',
		component: () => import('../views/search/index.vue')
	},
	// 局部搜索
	{
		path: '/search/details',
		name: 'search_details',
		component: () => import('../views/search/details.vue')
	}
]

const router = new VueRouter({
	mode: 'hash',
	base: process.env.BASE_URL,
	routes
})

router.afterEach((to, from, next) => {
	let title = "小智电商供应链管理系统-home";
	document.title = title;
	document.logo = "小智电商供应链管理系统"
})

router.beforeEach((to, from, next) => {
	window.scrollTo(0, 0);
	next();
});

export default router
