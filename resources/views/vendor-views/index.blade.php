@extends('layouts.vendor.master')
@section('title')
    {{__("index")}}
@endsection

@section('content')

    <!-- start page title -->
    <div class="row">
        <div class="col-12">
            <div class="page-title-box">
                <div class="page-title-right">
                    <form class="d-flex align-items-center mb-3">
                        <div class="input-group input-group-sm">
                            <input type="text" class="form-control border" id="dash-daterange">
                            <span class="input-group-text bg-blue border-blue text-white">
                          <i class="mdi mdi-calendar-range"></i>
                        </span>
                        </div>
                    </form>
                </div>
                <h4 class="page-title">مرحباً معاذ ،</h4>
            </div>
        </div>
    </div>
    <!-- end page title -->
    <div class="row">
        <div class="col-md-6 col-xl-3">
            <div class="widget-rounded-circle card">
                <div class="card-body">
                    <div class="row">
                        <div class="col-6">
                            <div class="avatar-lg rounded bg-soft-primary">
                                <i class="dripicons-wallet font-24 avatar-title text-primary"></i>
                            </div>
                        </div>
                        <div class="col-6">
                            <div class="text-end">
                                <h3 class="text-dark mt-1">{{__(config('app.currency'))}} <span data-plugin="counterup">{{$data['monthly_order_amount']}}</span>
                                </h3>
                                <p class="text-muted mb-1 text-truncate">الأرباح</p>
                            </div>
                        </div>
                    </div>
                    <!-- end row-->
                </div>
            </div>
            <!-- end widget-rounded-circle-->
        </div>
        <!-- end col-->
        <div class="col-md-6 col-xl-3">
            <div class="widget-rounded-circle card">
                <div class="card-body">
                    <div class="row">
                        <div class="col-6">
                            <div class="avatar-lg rounded bg-soft-success">
                                <i class="dripicons-basket font-24 avatar-title text-success"></i>
                            </div>
                        </div>
                        <div class="col-6">
                            <div class="text-end">
                                <a href="{{route('admin.order.index')}}">
                                    <h3 class="text-dark mt-1">
                                        <span data-plugin="counterup">{{$data['monthly_order_count']}}</span>
                                    </h3>
                                    <p class="text-muted mb-1 text-truncate">عدد الطلبات</p>
                                </a>
                            </div>
                        </div>
                    </div>
                    <!-- end row-->
                </div>
            </div>
            <!-- end widget-rounded-circle-->
        </div>
        <!-- end col-->
        <div class="col-md-6 col-xl-3">
            <div class="widget-rounded-circle card">
                <div class="card-body">
                    <div class="row">
                        <div class="col-6">
                            <div class="avatar-lg rounded bg-soft-info">
                                <i class="dripicons-store font-24 avatar-title text-info"></i>
                            </div>
                        </div>
                        <div class="col-6">
                            <a href="{{route('admin.place.index')}}">
                                <div class="text-end">
                                    <h3 class="text-dark mt-1">
                                        <span data-plugin="counterup">{{$data['monthly_product_count']}}</span>
                                    </h3>
                                    <p class="text-muted mb-1 text-truncate"> عدد المنتجات </p>
                                </div>
                            </a>
                        </div>
                    </div>
                    <!-- end row-->
                </div>
            </div>
            <!-- end widget-rounded-circle-->
        </div>
        <!-- end col-->
        <div class="col-md-6 col-xl-3">
            <div class="widget-rounded-circle card">
                <div class="card-body">
                    <div class="row">
                        <div class="col-6">
                            <div class="avatar-lg rounded bg-soft-warning">
                                <i class="dripicons-user-group font-24 avatar-title text-warning"></i>
                            </div>
                        </div>
                        <div class="col-6">
                            <div class="text-end">
                                <a href="{{route('admin.customer.index')}}">
                                    <h3 class="text-dark mt-1">
                                        <span data-plugin="counterup">{{$data['monthly_user_count']}}</span>
                                    </h3>
                                    <p class="text-muted mb-1 text-truncate">عدد المستخدمين</p>
                                </a>
                            </div>
                        </div>
                    </div>
                    <!-- end row-->
                </div>
            </div>
            <!-- end widget-rounded-circle-->
        </div>
        <!-- end col-->
    </div>
    <!-- end row -->
    <div class="row">
        <div class="col-xl-8"></div>
        <!-- end col-->
        <div class="col-xl-4"></div>
        <!-- end col-->
    </div>
    <!-- end row -->
    <div class="row">
        <div class="col-lg-12">
            <div class="card">
                <div class="card-body pb-2">
                    <h4 class="header-title mb-3">الارباح والمبيعات الشهرية</h4>
                    <div dir="ltr">
                        <div id="sales-analytics" class="mt-4" data-colors="#1abc9c,#4a81d4"></div>
                    </div>
                </div>
            </div>
            <!-- end card -->
        </div>
        <!-- end col-->
    </div>
    <div class="row">
        <div class="col-xl-6">
            <div class="card">
                <div class="card-body">
                    <h4 class="header-title mb-3">الأماكن الأكثر شهرة</h4>
                    <div class="table-responsive">
                        <table class="table table-borderless table-hover table-nowrap table-centered m-0">
                            <thead class="table-light">
                            <tr>
                                <th colspan="2">اسم المكان</th>
                                <th>التصنيف</th>
                                <th>عدد الطلبات</th>
                            </tr>
                            </thead>
                            <tbody>
                            @if($data['last_orders']->count()>0)
                                @foreach($data['last_orders'] as $key=>$order)
                            <tr>
                                <td style="width: 36px;">
                                <td class="m-0 fw-normal"> {{$order->id}}</td>
                                </td>
                                <td>
                                    <h5 class="m-0 fw-normal">{{$order->restaurant->name}}</h5>
                                </td>
                                <td>
                                    <h5 class="m-0 fw-normal">{{$order->amount}} {{__(config('app.currency'))}}</h5>
                                </td>
                                <td>
                                    <p class="mb-0 text-muted">
                                        <small>{{\Carbon\Carbon::parse($order->creared_at)->translatedFormat('l j F Y H:i:s')}}</small>
                                    </p>
                                </td>
                            </tr>
                                @endforeach
                            @else
                                <tr>
                                    <td colspan="9" class="text-center">
                                        {{__('no data available')}}
                                    </td>
                                </tr>

                            @endif

                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
        <!-- end col -->
        <div class="col-xl-6">
            <div class="card">
                <div class="card-body">
                    <h4 class="header-title mb-3">المنتجات الأكثر شراءاً</h4>
                    <div class="table-responsive">
                        <table class="table table-borderless table-nowrap table-hover table-centered m-0">
                            <thead class="table-light">
                            <tr>
                                <th>اسم المنتج</th>
                                <th>اسم المكان</th>
                                <th>عدد الطلبات</th>
                                <th>التقييم</th>
                            </tr>
                            </thead>
                            <tbody>
                            @if($data['top_products']->count()>0)
                                @foreach($data['top_products'] as $key=>$top_product)
                            <tr>
                                <td>
                                    <h5 class="m-0 fw-normal">{{$top_product->food->name}}</h5>
                                </td>
                                <td> {{$top_product->food->restaurant->name}} </td>
                                <td> {{$top_product->food_count}} طلبات </td>
                                <td>{{--\App\Modules\Core\Helper::calculate_restaurant_rating(json_encode($top_product->food->restaurant->rating))--}} </td>
                            </tr>
                                @endforeach
                            @else
                                <tr>
                                    <td colspan="9" class="text-center">
                                        {{__('no data available')}}
                                    </td>
                                </tr>

                            @endif

                            </tbody>
                        </table>
                    </div>
                    <!-- end .table-responsive-->
                </div>
            </div>
            <!-- end card-->
        </div>
        <!-- end col -->
    </div>
    <!-- end row -->
@endsection
