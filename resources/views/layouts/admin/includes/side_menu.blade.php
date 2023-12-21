<!-- ========== Menu ========== -->
<div class="app-menu">
    <!-- Brand Logo -->
    <div class="logo-box">
        <!-- Brand Logo Light -->
        <a href="{{route('admin.dashboard')}}" class="logo-light">
            <img src="{{asset('assets/images/logo.png')}}" alt="logo" class="logo-lg">
            <img src="{{asset('assets/images/logo.png')}}" alt="small logo" class="logo-sm">
        </a>
        <!-- Brand Logo Dark -->
        <a href="{{route('admin.dashboard')}}" class="logo-dark">
            <img src="{{asset('assets/images/logo.png')}}" alt="dark logo" class="logo-lg">
            <img src="{{asset('assets/images/logo.png')}}" alt="small logo" class="logo-sm">
        </a>
    </div>
    <!-- menu-left -->
    <div class="scrollbar">
        <!-- customer box -->
        <div class="user-box text-center">
            <img src="{{asset('assets/images/users/user-1.jpg')}}" alt="user-img" title="Mat Helme" class="rounded-circle avatar-md">
            <div class="dropdown">
                <a href="javascript: void(0);" class="dropdown-toggle h5 mb-1 d-block" data-bs-toggle="dropdown">Geneva Kennedy</a>
                <div class="dropdown-menu user-pro-dropdown">
                    <!-- item-->
                    <a href="javascript:void(0);" class="dropdown-item notify-item">
                        <i class="fe-user me-1"></i>
                        <span>الإعدادات</span>
                    </a>
                    <!-- item-->
                    <a href="{{route('admin.auth.logout')}}" class="dropdown-item notify-item">
                        <i class="fe-log-out me-1"></i>
                        <span>تسجيل الخروج</span>
                    </a>
                </div>
            </div>
        </div>
        <!--- Menu -->
        <ul class="menu">
            <li class="menu-item">
                <a href="{{route('admin.dashboard')}}" class="menu-link">
                <span class="menu-icon">
                  <i data-feather="airplay"></i>
                </span>
                    <span class="menu-text"> الرئيسية</span>
                </a>
            </li>
            <li class="menu-title"> العروض الترويجية</li>
            <li class="menu-item">
                <a href="notofications-list.html" class="menu-link">
                <span class="menu-icon">
                  <i data-feather="bell"></i>
                </span>
                    <span class="menu-text"> إرسال إشعارات</span>
                </a>
            </li>
            <li class="menu-item">
                <a href="{{route('admin.banner.index')}}" class="menu-link">
                <span class="menu-icon">
                  <i data-feather="target"></i>
                </span>
                    <span class="menu-text"> إنشاء إعلانات</span>
                </a>
            </li>
            <li class="menu-item">
                <a href="{{route('admin.coupon.index')}}" class="menu-link">
                <span class="menu-icon">
                  <i data-feather="percent"></i>
                </span>
                    <span class="menu-text"> كوبونات التخفيض</span>
                </a>
            </li>
            <li class="menu-title"> إدارة أصحاب المحلات</li>
            <li class="menu-item">
                <a href="{{route('admin.place.index')}}" class="menu-link">
                <span class="menu-icon">
                  <i data-feather="briefcase"></i>
                </span>
                    <span class="menu-text"> أصحاب المحلات</span>
                </a>
            </li>
            <li class="menu-item">
                <a href="{{route('admin.place.create')}}" class="menu-link">
                <span class="menu-icon">
                  <i data-feather="folder-plus"></i>
                </span>
                    <span class="menu-text"> إضافة صاحب محل</span>
                </a>
            </li>
            <li class="menu-item">
                <a href="{{route('admin.compilation.index')}}" class="menu-link">
                <span class="menu-icon">
                  <i data-feather="grid"></i>
                </span>
                    <span class="menu-text"> التصنيفات</span>
                </a>
            </li>
            <li class="menu-item">
                <a href="{{route('admin.compilation.create')}}" class="menu-link">
                <span class="menu-icon">
                  <i data-feather="target"></i>
                </span>
                    <span class="menu-text"> إضافة تصنيف</span>
                </a>
            </li>
            <li class="menu-title">إدارة العملاء</li>
            <li class="menu-item">
                <a href="{{route('admin.order.index')}}" class="menu-link">
                <span class="menu-icon">
                  <i data-feather="shopping-bag"></i>
                </span>
                    <span class="menu-text"> الطلبات</span>
                    <span class="badge bg-success rounded-pill ms-auto">4</span>
                </a>
            </li>
            <li class="menu-item">
                <a href="{{route('admin.customer.index')}}" class="menu-link">
                <span class="menu-icon">
                  <i data-feather="users"></i>
                </span>
                    <span class="menu-text"> العملاء</span>
                </a>
            </li>
            <li class="menu-item">
                <a href="refund-orders.html" class="menu-link">
                <span class="menu-icon">
                  <i data-feather="gift"></i>
                </span>
                    <a href="{{route('admin.order.index',['status'=>'refunded'])}}" class="menu-link">
                    <span class="menu-text"> الطلبات المستردة</span>
                    <span class="badge bg-success rounded-pill ms-auto">4</span>
                    </a>
                </a>
            </li>
            <li class="menu-item">
                <a href="{{route('admin.customer-wallet.create')}}" class="menu-link">
                <span class="menu-icon">
                  <i data-feather="gift"></i>
                </span>
                    <span class="menu-text"> شحن محفظة العميل</span>
                </a>
            </li>
            <li class="menu-title"> المساعدة</li>
            <li class="menu-item">
                <a href="{{ route('admin.message.list') }}" class="menu-link">
                <span class="menu-icon">
                  <i data-feather="message-square"></i>
                </span>
                    <span class="menu-text"> التواصل</span>
                    <span class="badge bg-success rounded-pill ms-auto">4</span>
                </a>
            </li>
            <li class="menu-title">إدارة عمليات البيع</li>
            <li class="menu-item">
                <a href="withdraw-transaction.html" class="menu-link">
                <span class="menu-icon">
                  <i data-feather="dollar-sign"></i>
                </span>
                    <span class="menu-text"> طلبات سحب الأموال</span>
                    <span class="badge bg-success rounded-pill ms-auto">4</span>
                </a>
            </li>
            <li class="menu-item">
                <a href="#" class="menu-link">
                <span class="menu-icon">
                  <i data-feather="credit-card"></i>
                </span>
                    <span class="menu-text"> وسائل الدفع</span>
                </a>
            </li>
            <li class="menu-title">إدارة الموظفين</li>
            <li class="menu-item">
                <a href="employees.html" class="menu-link">
                <span class="menu-icon">
                  <i data-feather="users"></i>
                </span>
                    <span class="menu-text">موظفي بسطة</span>
                </a>
            </li>
            <li class="menu-item">
                <a href="roles.html" class="menu-link">
                <span class="menu-icon">
                  <i data-feather="gitlab"></i>
                </span>
                    <span class="menu-text">الأدوار</span>
                </a>
            </li>
            <li class="menu-title">إدارة التقارير</li>
            <li class="menu-item">
                <a href="report-1.html" class="menu-link">
                <span class="menu-icon">
                  <i data-feather="trello"></i>
                </span>
                    <span class="menu-text">تقارير الطلبات</span>
                </a>
            </li>
            <li class="menu-item">
                <a href="report-2.html" class="menu-link">
                <span class="menu-icon">
                  <i data-feather="trello"></i>
                </span>
                    <span class="menu-text">تقارير المحلات</span>
                </a>
            </li>
            <li class="menu-item">
                <a href="report-3.html" class="menu-link">
                <span class="menu-icon">
                  <i data-feather="trello"></i>
                </span>
                    <span class="menu-text">تقارير العملاء</span>
                </a>
            </li>
            <li class="menu-item">
                <a href="report-4.html" class="menu-link">
                <span class="menu-icon">
                  <i data-feather="trello"></i>
                </span>
                    <span class="menu-text">تقارير الربح</span>
                </a>
            </li>
            <li class="menu-title">إعدادات البيزنس</li>
            <li class="menu-item">
                <a href="app-settings.html" class="menu-link">
                <span class="menu-icon">
                  <i data-feather="settings"></i>
                </span>
                    <span class="menu-text"> إعدادات البيزنس</span>
                </a>
            </li>
        </ul>
        <!--- End Menu -->
        <div class="clearfix"></div>
    </div>
</div>
<!-- ========== Left menu End ========== -->
