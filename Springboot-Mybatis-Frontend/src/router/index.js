import { createRouter, createWebHistory } from 'vue-router'
import UserList from '../views/UserList.vue'
import RoleList from '../views/RoleList.vue'
import Home from '../views/Home.vue'
import UserForm from '../views/UserForm.vue'
import RoleForm from '../views/RoleForm.vue'
import About from '../views/About.vue'

const routes = [
  {
    path: '/',
    name: 'Home',
    component: Home,
    meta: { title: '首页' }
  },
  {
    path: '/users',
    name: 'UserList',
    component: UserList,
    meta: { title: '用户管理' }
  },
  {
    path: '/users/add',
    name: 'UserAdd',
    component: UserForm,
    meta: { title: '添加用户' }
  },
  {
    path: '/users/edit/:id',
    name: 'UserEdit',
    component: UserForm,
    meta: { title: '编辑用户' }
  },
  {
    path: '/roles',
    name: 'RoleList',
    component: RoleList,
    meta: { title: '角色管理' }
  },
  {
    path: '/roles/add',
    name: 'RoleAdd',
    component: RoleForm,
    meta: { title: '添加角色' }
  },
  {
    path: '/roles/edit/:id',
    name: 'RoleEdit',
    component: RoleForm,
    meta: { title: '编辑角色' }
  },
  {
    path: '/users/:id',
    name: 'UserDetail',
    component: () => import('../views/UserDetail.vue'),
    meta: { title: '用户详情' }
  },
  {
    path: '/about',
    name: 'About',
    component: About,
    meta: {
      title: '联系作者'
    }
  }
]

const router = createRouter({
  history: createWebHistory(),
  routes
})

router.beforeEach((to, from, next) => {
  document.title = to.meta.title ? `${to.meta.title} - 后台管理系统` : '后台管理系统'
  next()
})

export default router 