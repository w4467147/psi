package io.finer.erp.jeecg.finance.controller;

import com.alibaba.fastjson.JSONObject;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import io.finer.erp.jeecg.finance.entity.FinPayableCheck;
import io.finer.erp.jeecg.finance.entity.FinPayableCheckEntry;
import io.finer.erp.jeecg.finance.service.IFinPayableCheckEntryService;
import io.finer.erp.jeecg.finance.service.IFinPayableCheckService;
import io.finer.erp.jeecg.finance.vo.FinPayableCheckPage;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import lombok.extern.slf4j.Slf4j;
import org.apache.shiro.SecurityUtils;
import org.jeecg.common.api.vo.Result;
import org.jeecg.common.aspect.annotation.AutoLog;
import org.jeecg.common.system.query.QueryGenerator;
import org.jeecg.common.system.vo.LoginUser;
import org.jeecg.common.util.oConvertUtils;
import org.jeecgframework.poi.excel.ExcelImportUtil;
import org.jeecgframework.poi.excel.def.NormalExcelConstants;
import org.jeecgframework.poi.excel.entity.ExportParams;
import org.jeecgframework.poi.excel.entity.ImportParams;
import org.jeecgframework.poi.excel.view.JeecgEntityExcelView;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

/**
* @Description: 往来核销单
* @Author: jeecg-boot
* @Date:   2020-04-17
* @Version: V1.0
*/
@Api(tags="往来核销单")
@RestController
@RequestMapping("/finance/finPayableCheck")
@Slf4j
public class FinPayableCheckController {
   @Autowired
   private IFinPayableCheckService finPayableCheckService;
    @Autowired
    private IFinPayableCheckEntryService finPayableCheckEntryService;

   /**
    * 分页列表查询
    *
    * @param finPayableCheck
    * @param pageNo
    * @param pageSize
    * @param req
    * @return
    */
   @AutoLog(value = "往来核销单-分页列表查询")
   @ApiOperation(value="往来核销单-分页列表查询", notes="往来核销单-分页列表查询")
   @GetMapping(value = {"/list", "/list/{payableCheckType}"})  //payableCheckType会传至finPayableCheck.payableCheckType
   public Result<?> queryPageList(FinPayableCheck finPayableCheck,
                                  @RequestParam(name="pageNo", defaultValue="1") Integer pageNo,
                                  @RequestParam(name="pageSize", defaultValue="10") Integer pageSize,
                                  HttpServletRequest req) {
       QueryWrapper<FinPayableCheck> queryWrapper = QueryGenerator.initQueryWrapper(finPayableCheck, req.getParameterMap());
       Page<FinPayableCheck> page = new Page<FinPayableCheck>(pageNo, pageSize);
       IPage<FinPayableCheck> pageList = finPayableCheckService.page(page, queryWrapper);
       return Result.ok(pageList);
   }
   
   /**
    *   添加
    *
    * @param finPayableCheckPage
    * @return
    */
   @AutoLog(value = "往来核销单-添加")
   @ApiOperation(value="往来核销单-添加", notes="往来核销单-添加")
   @PostMapping(value = "/add")
   public Result<?> add(@RequestBody FinPayableCheckPage finPayableCheckPage) {
       FinPayableCheck finPayableCheck = new FinPayableCheck();
       BeanUtils.copyProperties(finPayableCheckPage, finPayableCheck);
       finPayableCheckService.saveMain(finPayableCheck, finPayableCheckPage.getFinPayableCheckEntryList());
       return Result.ok("添加成功！");
   }
   
   /**
    *  编辑
    *
    * @param finPayableCheckPage
    * @return
    */
   @AutoLog(value = "往来核销单-编辑")
   @ApiOperation(value="往来核销单-编辑", notes="往来核销单-编辑")
   @PutMapping(value = "/edit")
   public Result<?> edit(@RequestBody FinPayableCheckPage finPayableCheckPage) {
       FinPayableCheck finPayableCheck = new FinPayableCheck();
       BeanUtils.copyProperties(finPayableCheckPage, finPayableCheck);
       FinPayableCheck finPayableCheckEntity = finPayableCheckService.getById(finPayableCheck.getId());
       if(finPayableCheckEntity==null) {
           return Result.error("未找到对应数据");
       }
       finPayableCheckService.updateMain(finPayableCheck, finPayableCheckPage.getFinPayableCheckEntryList());
       return Result.ok("编辑成功!");
   }
   
   /**
    *   通过id删除
    *
    * @param id
    * @return
    */
   @AutoLog(value = "往来核销单-通过id删除")
   @ApiOperation(value="往来核销单-通过id删除", notes="往来核销单-通过id删除")
   @DeleteMapping(value = "/delete")
   public Result<?> delete(@RequestParam(name="id",required=true) String id) {
       finPayableCheckService.delMain(id);
       return Result.ok("删除成功!");
   }
   
   /**
    *  批量删除
    *
    * @param ids
    * @return
    */
   @AutoLog(value = "往来核销单-批量删除")
   @ApiOperation(value="往来核销单-批量删除", notes="往来核销单-批量删除")
   @DeleteMapping(value = "/deleteBatch")
   public Result<?> deleteBatch(@RequestParam(name="ids",required=true) String ids) {
       this.finPayableCheckService.delBatchMain(Arrays.asList(ids.split(",")));
       return Result.ok("批量删除成功！");
   }
   
   /**
    * 通过id查询
    *
    * @param id
    * @return
    */
   @AutoLog(value = "往来核销单-通过id查询")
   @ApiOperation(value="往来核销单-通过id查询", notes="往来核销单-通过id查询")
   @GetMapping(value = "/queryById")
   public Result<?> queryById(@RequestParam(name="id",required=true) String id) {
       FinPayableCheck finPayableCheck = finPayableCheckService.getById(id);
       if(finPayableCheck==null) {
           return Result.error("未找到对应数据");
       }
       return Result.ok(finPayableCheck);

   }

   /**
    * 通过id查询
    *
    * @param id
    * @return
    */
   @AutoLog(value = "往来核销明细集合-通过id查询")
   @ApiOperation(value="往来核销明细集合-通过id查询", notes="往来核销明细-通过id查询")
   @GetMapping(value = "/queryFinPayableCheckEntryByMainId")
   public Result<?> queryFinPayableCheckEntryListByMainId(@RequestParam(name="id",required=true) String id) {
       List<FinPayableCheckEntry> finPayableCheckEntryList = finPayableCheckEntryService.selectByMainId(id);
       return Result.ok(finPayableCheckEntryList);
   }


    /**
   * 导出excel
   *
   * @param request
   * @param finPayableCheck
   */
   @RequestMapping(value = {"/exportXls", "/exportXls/{payableCheckType}"})
   public ModelAndView exportXls(HttpServletRequest request, FinPayableCheck finPayableCheck) {
     // Step.1 组装查询条件查询数据
     QueryWrapper<FinPayableCheck> queryWrapper = QueryGenerator.initQueryWrapper(finPayableCheck, request.getParameterMap());
     LoginUser sysUser = (LoginUser) SecurityUtils.getSubject().getPrincipal();

     //Step.2 获取导出数据
     List<FinPayableCheck> queryList = finPayableCheckService.list(queryWrapper);
     // 过滤选中数据
     String selections = request.getParameter("selections");
     List<FinPayableCheck> finPayableCheckList = new ArrayList<FinPayableCheck>();
     if(oConvertUtils.isEmpty(selections)) {
         finPayableCheckList = queryList;
     }else {
         List<String> selectionList = Arrays.asList(selections.split(","));
         finPayableCheckList = queryList.stream().filter(item -> selectionList.contains(item.getId())).collect(Collectors.toList());
     }

     // Step.3 组装pageList
     List<FinPayableCheckPage> pageList = new ArrayList<FinPayableCheckPage>();
     for (FinPayableCheck main : finPayableCheckList) {
         FinPayableCheckPage vo = new FinPayableCheckPage();
         BeanUtils.copyProperties(main, vo);
         List<FinPayableCheckEntry> finPayableCheckEntryList = finPayableCheckEntryService.selectByMainId(main.getId());
         vo.setFinPayableCheckEntryList(finPayableCheckEntryList);
         pageList.add(vo);
     }

     // Step.4 AutoPoi 导出Excel
     ModelAndView mv = new ModelAndView(new JeecgEntityExcelView());
     mv.addObject(NormalExcelConstants.FILE_NAME, "往来核销单列表");
     mv.addObject(NormalExcelConstants.CLASS, FinPayableCheckPage.class);
     mv.addObject(NormalExcelConstants.PARAMS, new ExportParams("往来核销单数据", "导出人:"+sysUser.getRealname(), "往来核销单"));
     mv.addObject(NormalExcelConstants.DATA_LIST, pageList);
     return mv;
   }

   /**
   * 通过excel导入数据
   *
   * @param request
   * @param response
   * @return
   */
   @RequestMapping(value = "/importExcel", method = RequestMethod.POST)
   public Result<?> importExcel(HttpServletRequest request, HttpServletResponse response) {
     MultipartHttpServletRequest multipartRequest = (MultipartHttpServletRequest) request;
     Map<String, MultipartFile> fileMap = multipartRequest.getFileMap();
     for (Map.Entry<String, MultipartFile> entity : fileMap.entrySet()) {
         MultipartFile file = entity.getValue();// 获取上传文件对象
         ImportParams params = new ImportParams();
         params.setTitleRows(2);
         params.setHeadRows(1);
         params.setNeedSave(true);
         try {
             List<FinPayableCheckPage> list = ExcelImportUtil.importExcel(file.getInputStream(), FinPayableCheckPage.class, params);
             for (FinPayableCheckPage page : list) {
                 FinPayableCheck po = new FinPayableCheck();
                 BeanUtils.copyProperties(page, po);
                 finPayableCheckService.saveMain(po, page.getFinPayableCheckEntryList());
             }
             return Result.ok("文件导入成功！数据行数:" + list.size());
         } catch (Exception e) {
             log.error(e.getMessage(),e);
             return Result.error("文件导入失败:"+e.getMessage());
         } finally {
             try {
                 file.getInputStream().close();
             } catch (IOException e) {
                 e.printStackTrace();
             }
         }
     }
     return Result.ok("文件导入失败！");
   }

    @AutoLog(value = "往来核销单-通过id审核")
    @ApiOperation(value="往来核销单-通过id审核", notes="往来核销单-通过id审核")
    @PutMapping(value = "/approve")
    public Result<?> approve(@RequestBody JSONObject json) {
        finPayableCheckService.approve(json.getString("id"));
        return Result.ok("审核通过!");
    }

}
