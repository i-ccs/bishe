import Vue from 'vue';
import VueRouter from 'vue-router';
import index from '../views/index.vue';
import login from '../views/login.vue';
import forgot from '../views/forgot.vue';
Vue.use(VueRouter)

const routes = [
    // 主页
    {
        path: '/',
        name: 'index',
        component: index,
        meta: {
            index: 0,
            title: '首页'
        }
    },

    // 登录
    {
        path: '/login',
        name: 'login',
        component: login,
        meta: {
            index: 0,
            title: '登录'
        }
    },



    // 忘记密码
    {
        path: '/forgot',
        name: "forgot",
        component: forgot,
        meta: {
            index: 0,
            title: '忘记密码'
        }
    },

    // 修改密码
    {
        path: '/user/password',
        name: "password",
        component: () => import("../views/user/password.vue"),
        meta: {
            index: 0,
            title: '修改密码'
        }
    },

    // 视频播放页
    {
        path: "/media/video",
        name: "video",
        component: () => import('../views/media/video.vue'),
        meta: {
            index: 0,
            title: "视频"
        }
    },

    // 音频播放页
    {
        path: "/media/audio",
        name: "audio",
        component: () => import('../views/media/audio.vue'),
        meta: {
            index: 0,
            title: "音频"
        }
    },



    // 轮播图路由
    {
        path: '/slides/table',
        name: 'slides_table',
        component: () => import('../views/slides/table.vue'),
        meta: {
            index: 0,
            title: '轮播图列表'
        }
    },
    {
        path: '/slides/view',
        name: 'slides_view',
        component: () => import('../views/slides/view.vue'),
        meta: {
            index: 0,
            title: '轮播图详情'
        }
    },
    // 文章路由
    {
        path: '/article/table',
        name: 'article_table',
        component: () => import('../views/article/table.vue'),
        meta: {
            index: 0,
            title: '行业资讯列表'
        }
    },
    {
        path: '/article/view',
        name: 'article_view',
        component: () => import('../views/article/view.vue'),
        meta: {
            index: 0,
            title: '行业资讯详情'
        }
    },

    // 文章分类路由
    {
        path: '/article_type/table',
        name: 'article_type_table',
        component: () => import('../views/article_type/table.vue'),
        meta: {
            index: 0,
            title: '行业资讯分类列表'
        }
    },
    {
        path: '/article_type/view',
        name: 'article_type_view',
        component: () => import('../views/article_type/view.vue'),
        meta: {
            index: 0,
            title: '行业资讯分类详情'
        }
    },



    // 公告路由
    {
        path: '/notice/table',
        name: 'notice_table',
        component: () => import('../views/notice/table.vue'),
        meta: {
            index: 0,
            title: '公告信息列表'
        }
    },
    {
        path: '/notice/view',
        name: 'notice_view',
        component: () => import('../views/notice/view.vue'),
        meta: {
            index: 0,
            title: '公告信息详情'
        }
    },

    // 评论路由
    {
        path: '/comment/table',
        name: 'comment_table',
        component: () => import('../views/comment/table.vue'),
        meta: {
            index: 0,
            title: '评论列表'
        }
    },
    {
        path: '/comment/view',
        name: 'comment_view',
        component: () => import('../views/comment/view.vue'),
        meta: {
            index: 0,
            title: '评论详情'
        }
    },
    // 注册用户路由
    {
        path: '/registered_user/table',
        name: 'registered_user_table',
        component: () => import('../views/registered_user/table.vue'),
        meta: {
            index: 0,
            title: '注册用户列表'
        }
    },
    {
        path: '/registered_user/view',
        name: 'registered_user_view',
        component: () => import('../views/registered_user/view.vue'),
        meta: {
            index: 0,
            title: '注册用户详情'
        }
    },
    // 商品信息路由
    {
        path: '/merchandise_information/table',
        name: 'merchandise_information_table',
        component: () => import('../views/merchandise_information/table.vue'),
        meta: {
            index: 0,
            title: '商品信息列表'
        }
    },
    {
        path: '/merchandise_information/view',
        name: 'merchandise_information_view',
        component: () => import('../views/merchandise_information/view.vue'),
        meta: {
            index: 0,
            title: '商品信息详情'
        }
    },
    // 销售信息路由
    {
        path: '/sales_information/table',
        name: 'sales_information_table',
        component: () => import('../views/sales_information/table.vue'),
        meta: {
            index: 0,
            title: '销售信息列表'
        }
    },
    {
        path: '/sales_information/view',
        name: 'sales_information_view',
        component: () => import('../views/sales_information/view.vue'),
        meta: {
            index: 0,
            title: '销售信息详情'
        }
    },
    // 供应信息路由
    {
        path: '/supply_information/table',
        name: 'supply_information_table',
        component: () => import('../views/supply_information/table.vue'),
        meta: {
            index: 0,
            title: '供应信息列表'
        }
    },
    {
        path: '/supply_information/view',
        name: 'supply_information_view',
        component: () => import('../views/supply_information/view.vue'),
        meta: {
            index: 0,
            title: '供应信息详情'
        }
    },
    // 采购信息路由
    {
        path: '/purchasing_information/table',
        name: 'purchasing_information_table',
        component: () => import('../views/purchasing_information/table.vue'),
        meta: {
            index: 0,
            title: '采购信息列表'
        }
    },
    {
        path: '/purchasing_information/view',
        name: 'purchasing_information_view',
        component: () => import('../views/purchasing_information/view.vue'),
        meta: {
            index: 0,
            title: '采购信息详情'
        }
    },
    // 库存信息路由
    {
        path: '/inventory_information/table',
        name: 'inventory_information_table',
        component: () => import('../views/inventory_information/table.vue'),
        meta: {
            index: 0,
            title: '库存信息列表'
        }
    },
    {
        path: '/inventory_information/view',
        name: 'inventory_information_view',
        component: () => import('../views/inventory_information/view.vue'),
        meta: {
            index: 0,
            title: '库存信息详情'
        }
    },
    // 用户路由
    {
        path: '/user/table',
        name: 'user_table',
        component: () => import('../views/user/table.vue'),
        meta: {
            index: 0,
            title: '用户列表'
        }
    },
    {
        path: '/user/view',
        name: 'user_view',
        component: () => import('../views/user/view.vue'),
        meta: {
            index: 0,
            title: '用户详情'
        }
    },
    {
        path: '/user/info',
        name: 'user_info',
        component: () => import('../views/user/info.vue'),
        meta: {
            index: 0,
            title: '个人信息'
        }
    },
    // 用户组路由
    {
        path: '/user_group/table',
        name: 'user_group_table',
        component: () => import('../views/user_group/table.vue'),
        meta: {
            index: 0,
            title: '用户组列表'
        }
    },
    {
        path: '/user_group/view',
        name: 'user_group_view',
        component: () => import('../views/user_group/view.vue'),
        meta: {
            index: 0,
            title: '用户组详情'
        }
    }
]

const router = new VueRouter({
    mode: 'hash',
    base: process.env.BASE_URL,
    routes
})

router.beforeEach((to, from, next) => {
    let token = to.query.token;
    if (token) {
        $.db.set("token", token, 120);
    }
    next();
})

router.afterEach((to, from, next) => {
    let title = "电商平台供应链管理系统-admin";
    document.title = title;
})

export default router
