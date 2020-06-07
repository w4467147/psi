package io.finer.erp.jeecg.finance.controller;

import com.alibaba.fastjson.JSONObject;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import io.finer.erp.jeecg.finance.entity.FinReceivableCheck;
import io.finer.erp.jeecg.finance.entity.FinReceivableCheckEntry;
import io.finer.erp.jeecg.finance.service.IFinReceivableCheckEntryService;
import io.finer.erp.jeecg.finance.service.IFinReceivableCheckService;
import io.finer.erp.jeecg.finance.vo.FinReceivableCheckPage;
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
@RequestMapping("/finance/finReceivableCheck")
@Slf4j
public class FinReceivableCheckController {
   @Autowired
   private IFinReceivableCheckService finReceivableCheckService;
    @Autowired
    private IFinReceivableCheckEntryService finReceivableCheckEntryService;

   /**
    * 分页列表查询
    *
    * @param finReceivableCheck
    * @param pageNo
    * @param pageSize
    * @param req
    * @return
    */
   @AutoLog(value = "往来核销单-分页列表查询")
   @ApiOperation(value="往来核销单-分页列表查询", notes="往来核销单-分页列表查询")
   @GetMapping(value = {"/list", "/list/{receivableCheckType}"})  //receivableCheckType会传至finReceivableCheck.receivableCheckTypeCheckType
   public Result<?> queryPageList(FinReceivableCheck finReceivableCheck,
                                  @RequestParam(name="pageNo", defaultValue="1") Integer pageNo,
                                  @RequestParam(name="pageSize", defaultValue="10") Integer pageSize,
                                  HttpServletRequest req) {
       QueryWrapper<FinReceivableCheck> queryWrapper = QueryGenerator.initQueryWrapper(finReceivableCheck, req.getParameterMap());
       Page<FinReceivableCheck> page = new Page<FinReceivableCheck>(pageNo, pageSize);
       IPage<FinReceivableCheck> pageList = finReceivableCheckService.page(page, queryWrapper);
       return Result.ok(pageList);
   }
   
   /**
    *   添加
    *
    * @param finReceivableCheckPage
    * @return
    */
   @AutoLog(value = "往来核销单-添加")
   @ApiOperation(value="往来核销单-添加", notes="往来核销单-添加")
   @PostMapping(value = "/add")
   public Result<?> add(@RequestBody FinReceivableCheckPage finReceivableCheckPage) {
       FinReceivableCheck finReceivableCheck = new FinReceivableCheck();
       BeanUtils.copyProperties(finReceivableCheckPage, finReceivableCheck);
       finReceivableCheckService.saveMain(finReceivableCheck, finReceivableCheckPage.getFinReceivableCheckEntryList());
       return Result.ok("添加成功！");
   }
   
   /**
    *  编辑
    *
    * @param finReceivableCheckPage
    * @return
    */
   @AutoLog(value = "往来核销单-编辑")
   @ApiOperation(value="往来核销单-编辑", notes="往来核销单-编辑")
   @PutMapping(value = "/edit")
   public Result<?> edit(@RequestBody FinReceivableCheckPage finReceivableCheckPage) {
       FinReceivableCheck finReceivableCheck = new FinReceivableCheck();
       BeanUtils.copyProperties(finReceivableCheckPage, finReceivableCheck);
       FinReceivableCheck finReceivableCheckEntity = finReceivableCheckService.getById(finReceivableCheck.getId());
       if(finReceivableCheckEntity==null) {
           return Result.error("未找到对应数据");
       }
       finReceivableCheckService.updateMain(finReceivableCheck, finReceivableCheckPage.getFinReceivableCheckEntryList());
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
       finReceivableCheckService.delMain(id);
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
       this.finReceivableCheckService.delBatchMain(Arrays.asList(ids.split(",")));
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
       FinReceivableCheck finReceivableCheck = finReceivableCheckService.getById(id);
       if(finReceivableCheck==null) {
           return Result.error("未找到对应数据");
       }
       return Result.ok(finReceivableCheck);

   }

   /**
    * 通过id查询
    *
    * @param id
    * @return
    */
   @AutoLog(value = "往来核销明细集合-通过id查询")
   @ApiOperation(value="往来核销明细集合-通过id查询", notes="往来核销明细-通过id查询")
   @GetMapping(value = "/queryFinReceivableCheckEntryByMainId")
   public Result<?> queryFinReceivableCheckEntryListByMainId(@RequestParam(name="id",required=true) String id) {
       List<FinReceivableCheckEntry> finReceivableCheckEntryList = finReceivableCheckEntryService.selectByMainId(id);
       return Result.ok(finReceivableCheckEntryList);
   }


    /**
   * 导出excel
   *
   * @param request
   * @param finReceivableCheck
   */
    @RequestMapping(value = {"/exportXls", "/exportXls/{receivableCheckType}"})
    public ModelAndView exportXls(HttpServletRequest request, FinReceivableCheck finReceivableCheck) {
     // Step.1 组装查询条件查询数据
     QueryWrapper<FinReceivableCheck> queryWrapper = QueryGenerator.initQueryWrapper(finReceivableCheck, request.getParameterMap());
     LoginUser sysUser = (LoginUser) SecurityUtils.getSubject().getPrincipal();

     //Step.2 获取导出数据
     List<FinReceivableCheck> queryList = finReceivableCheckService.list(queryWrapper);
     // 过滤选中数据
     String selections = request.getParameter("selections");
     List<FinReceivableCheck> finReceivableCheckList = new ArrayList<FinReceivableCheck>();
     if(oConvertUtils.isEmpty(selections)) {
         finReceivableCheckList = queryList;
     }else {
         List<String> selectionList = Arrays.asList(selections.split(","));
         finReceivableCheckList = queryList.stream().filter(item -> selectionList.contains(item.getId())).collect(Collectors.toList());
     }

     // Step.3 组装pageList
     List<FinReceivableCheckPage> pageList = new ArrayList<FinReceivableCheckPage>();
     for (FinReceivableCheck main : finReceivableCheckList) {
         FinReceivableCheckPage vo = new FinReceivableCheckPage();
         BeanUtils.copyProperties(main, vo);
         List<FinReceivableCheckEntry> finReceivableCheckEntryList = finReceivableCheckEntryService.selectByMainId(main.getId());
         vo.setFinReceivableCheckEntryList(finReceivableCheckEntryList);
         pageList.add(vo);
     }

     // Step.4 AutoPoi 导出Excel
     ModelAndView mv = new ModelAndView(new JeecgEntityExcelView());
     mv.addObject(NormalExcelConstants.FILE_NAME, "往来核销单列表");
     mv.addObject(NormalExcelConstants.CLASS, FinReceivableCheckPage.class);
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
             List<FinReceivableCheckPage> list = ExcelImportUtil.importExcel(file.getInputStream(), FinReceivableCheckPage.class, params);
             for (FinReceivableCheckPage page : list) {
                 FinReceivableCheck po = new FinReceivableCheck();
                 BeanUtils.copyProperties(page, po);
                 finReceivableCheckService.saveMain(po, page.getFinReceivableCheckEntryList());
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
        finReceivableCheckService.approve(json.getString("id"));
        return Result.ok("审核通过!");
    }

}
