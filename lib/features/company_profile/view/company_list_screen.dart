import 'package:after_layout/after_layout.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jobxprss_company/features/company_profile/models/company.dart';
import 'package:jobxprss_company/features/company_profile/view_model/company_list_view_model.dart';
import 'package:jobxprss_company/main_app/app_theme/app_theme.dart';
import 'package:jobxprss_company/main_app/failure/app_error.dart';
import 'package:jobxprss_company/main_app/resource/strings_resource.dart';
import 'package:jobxprss_company/main_app/views/widgets/custom_text_field.dart';
import 'package:jobxprss_company/main_app/views/widgets/failure_widget.dart';
import 'package:jobxprss_company/main_app/views/widgets/loader.dart';
import 'package:provider/provider.dart';

import 'company_details.dart';
import 'company_list_tile.dart';

class CompanyListScreen extends StatefulWidget {
  @override
  _CompanyListScreenState createState() => _CompanyListScreenState();
}

class _CompanyListScreenState extends State<CompanyListScreen>
    with AfterLayoutMixin {
  TextEditingController _searchTextEditingController = TextEditingController();
  FocusNode _searchFieldFocusNode = FocusNode();
  ScrollController _scrollController = ScrollController();

//  Company selectedCompany;

  @override
  void afterFirstLayout(BuildContext context) {
    var companyViewModel =
        Provider.of<CompanyListViewModel>(context, listen: false);
    companyViewModel.getCompanyList();

    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        companyViewModel.getMoreData();
      }
    });
  }

  errorWidget() {
    var vm = Provider.of<CompanyListViewModel>(context, listen: false);
    switch (vm.appError) {
      case AppError.serverError:
        return FailureFullScreenWidget(
          errorMessage: StringResources.unableToLoadData,
          onTap: () {
            return vm.refresh();
          },
        );

      case AppError.networkError:
        return FailureFullScreenWidget(
          errorMessage: StringResources.unableToReachServerMessage,
          onTap: () {
            return vm.refresh();
          },
        );

      default:
        return FailureFullScreenWidget(
          errorMessage: StringResources.somethingIsWrong,
          onTap: () {
            return vm.refresh();
          },
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    var companyViewModel = Provider.of<CompanyListViewModel>(context);
    List<Company> companySuggestion = companyViewModel.companyList == null
        ? []
        : companyViewModel.companyList;
    void search() {
      companyViewModel.query = _searchTextEditingController.text;
      companyViewModel.getCompanyList();
//      print(companyViewModel.companyList.length);
    }

    var backgroundColor = Theme.of(context).backgroundColor;
    var scaffoldBackgroundColor = Theme.of(context).scaffoldBackgroundColor;
    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    var titleStyle = TextStyle(fontSize: 16, fontWeight: FontWeight.w600);
    double iconSize = 14.0;
    var subtitleColor = isDarkMode ? Colors.white : AppTheme.grey;
    var isInSearchMode = companyViewModel.isInSearchMode;

    return WillPopScope(
      onWillPop: () async {
//        if(companyViewModel.isInSearchMode){
//          companyViewModel.toggleIsInSearchMode();
//          return false;
//        };
        companyViewModel.clearSearch();
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(StringResources.companyListAppbarText),
          actions: [
            IconButton(
              icon: Icon(isInSearchMode ? Icons.close : Icons.search),
              onPressed: () {
                _searchTextEditingController?.clear();
                companyViewModel.toggleIsInSearchMode();

                if (companyViewModel.isInSearchMode) {
                  _searchFieldFocusNode.requestFocus();
                } else {
                  _searchFieldFocusNode.unfocus();
                }
              },
            ),
//          IconButton(
//            icon: Icon(Icons.filter_list),
//            onPressed: () {
//              _scaffoldKey.currentState.openEndDrawer();
//            },
//          )
          ],
        ),
        body: RefreshIndicator(
          onRefresh: companyViewModel.refresh,
          child: Column(
            children: [
              if (companyViewModel.isInSearchMode)
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4),
                  child: CustomTextField(
                    focusNode: _searchFieldFocusNode,
                    controller: _searchTextEditingController,
                    hintText: StringResources.companyListSearchText,
                    autofocus: true,
                    textInputAction: TextInputAction.search,
                    onSubmitted: (v) {
                      search();
//                    if (_companyNameController.text.length > 2) {
//                      search();
//                    } else {
//                      BotToast.showText(text: StringUtils.searchLetterCapText);
//                    }
                    },
//                  onChanged: (v) {
//                    if (_searchTextEditingController.text.isEmpty) {
//                      companyViewModel.resetState();
//                    }
//                  },
                    suffixIcon: IconButton(
                      icon: Icon(Icons.search),
                      onPressed: () {
                        search();
//                      if (_companyNameController.text.length > 2) {
//                        search();
//                      } else {
//                        BotToast.showText(
//                            text: StringUtils.searchLetterCapText);
//                      }
                      },
                    ),
                  ),
                ),
//            SizedBox(height: 5,),

              companyViewModel.shouldShowCompanyCount
                  ? Container(
                      padding: EdgeInsets.symmetric(vertical: 5),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(companyViewModel.companiesCount.toString()),
//                                  if(companyViewModel.shouldShowCompanyCount)
                          companyViewModel.companiesCount > 1
                              ? Text(' ' +
                                  StringResources
                                      .companyListMultipleCompaniesFoundText)
                              : Text(' ' +
                                  StringResources.companyListSingleCompanyFoundText)
                        ],
                      ))
                  : SizedBox(),

              companyViewModel.shouldShowLoader
                  ? Padding(
                      padding: const EdgeInsets.only(top: 15),
                      child: Loader(),
                    )
                  : Container(
                      child: companyViewModel.shouldShowAppError
                          ? errorWidget()
                          : Expanded(
                              child: ListView.builder(
                                  controller: _scrollController,
                                  itemCount: companySuggestion.length + 1,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    if (index == companySuggestion.length) {
                                      return companyViewModel.isFetchingMoreData
                                          ? Loader()
                                          : SizedBox();
                                    }
                                    return GestureDetector(
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              CupertinoPageRoute(
                                                  builder: (context) =>
                                                      CompanyDetails(
                                                        company:
                                                            companySuggestion[
                                                                index],
                                                      )));
                                        },
                                        child: CompanyListTile(
                                          company: companySuggestion[index],
                                        ));
                                  }),
                            ),
                    )
            ],
          ),
        ),
      ),
    );
  }
}
