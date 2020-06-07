package io.finer.erp.jeecg.finance.controller;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import io.finer.erp.jeecg.finance.entity.FinPayableCheckEntry;
import io.finer.erp.jeecg.finance.service.IFinPayableCheckEntryService;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import lombok.extern.slf4j.Slf4j;
import org.jeecg.common.api.vo.Result;
import org.jeecg.common.aspect.annotation.AutoLog;
import org.jeecg.common.system.base.controller.JeecgController;
import org.jeecg.common.system.query.QueryGenerator;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.Arrays;

/**
* @Description: fin_payable_check_entry
* @Author: jeecg-boot
* @Date:   2020-04-17
* @Version: V1.0
*/
@Api(tags="fin_payable_check_entry")
@RestController
@RequestMapping("/finance/finPayableCheckEntry")
@Slf4j
public class FinPayableCheckEntryController extends JeecgController<FinPayableCheckEntry, IFinPayableCheckEntryService> {
   @Autowired
   private IFinPayableCheckEntryService finPayableCheckEntryService;
   
   /**
    * 分页列表查询
    *
    * @param finPayableCheckEntry
    * @param pageNo
    * @param pageSize
    * @param req
    * @return
    */
   @AutoLog(value = "fin_payable_check_entry-分页列表查询")
   @ApiOperation(value="fin_payable_check_entry-分页列表查询", notes="fin_payable_check_entry-分页列表查询")
   @GetMapping(value = "/list")
   public Result<?> queryPageList(FinPayableCheckEntry finPayableCheckEntry,
                                  @RequestParam(name="pageNo", defaultValue="1") Integer pageNo,
                                  @RequestParam(name="pageSize", defaultValue="10") Integer pageSize,
                                  HttpServletRequest req) {
       QueryWrapper<FinPayableCheckEntry> queryWrapper = QueryGenerator.initQueryWrapper(finPayableCheckEntry, req.getParameterMap());
       Page<FinPayableCheckEntry> page = new Page<FinPayableCheckEntry>(pageNo, pageSize);
       IPage<FinPayableCheckEntry> pageList = finPayableCheckEntryService.page(page, queryWrapper);
       return Result.ok(pageList);
   }
   
   /**
    *   添加
    *
    * @param finPayableCheckEntry
    * @return
    */
   @AutoLog(value = "fin_payable_check_entry-添加")
   @ApiOperation(value="fin_payable_check_entry-添加", notes="fin_payable_check_entry-添加")
   @PostMapping(value = "/add")
   public Result<?> add(@RequestBody FinPayableCheckEntry finPayableCheckEntry) {
       finPayableCheckEntryService.save(finPayableCheckEntry);
       return Result.ok("添加成功！");
   }
   
   /**
    *  编辑
    *
    * @param finPayableCheckEntry
    * @return
    */
   @AutoLog(value = "fin_payable_check_entry-编辑")
   @ApiOperation(value="fin_payable_check_entry-编辑", notes="fin_payable_check_entry-编辑")
   @PutMapping(value = "/edit")
   public Result<?> edit(@RequestBody FinPayableCheckEntry finPayableCheckEntry) {
       finPayableCheckEntryService.updateById(finPayableCheckEntry);
       return Result.ok("编辑成功!");
   }
   
   /**
    *   通过id删除
    *
    * @param id
    * @return
    */
   @AutoLog(value = "fin_payable_check_entry-通过id删除")
   @ApiOperation(value="fin_payable_check_entry-通过id删除", notes="fin_payable_check_entry-通过id删除")
   @DeleteMapping(value = "/delete")
   public Result<?> delete(@RequestParam(name="id",required=true) String id) {
       finPayableCheckEntryService.removeById(id);
       return Result.ok("删除成功!");
   }
   
   /**
    *  批量删除
    *
    * @param ids
    * @return
    */
   @AutoLog(value = "fin_payable_check_entry-批量删除")
   @ApiOperation(value="fin_payable_check_entry-批量删除", notes="fin_payable_check_entry-批量删除")
   @DeleteMapping(value = "/deleteBatch")
   public Result<?> deleteBatch(@RequestParam(name="ids",required=true) String ids) {
       this.finPayableCheckEntryService.removeByIds(Arrays.asList(ids.split(",")));
       return Result.ok("批量删除成功!");
   }
   
   /**
    * 通过id查询
    *
    * @param id
    * @return
    */
   @AutoLog(value = "fin_payable_check_entry-通过id查询")
   @ApiOperation(value="fin_payable_check_entry-通过id查询", notes="fin_payable_check_entry-通过id查询")
   @GetMapping(value = "/queryById")
   public Result<?> queryById(@RequestParam(name="id",required=true) String id) {
       FinPayableCheckEntry finPayableCheckEntry = finPayableCheckEntryService.getById(id);
       if(finPayableCheckEntry==null) {
           return Result.error("未找到对应数据");
       }
       return Result.ok(finPayableCheckEntry);
   }

    /**
   * 导出excel
   *
   * @param request
   * @param finPayableCheckEntry
   */
   @RequestMapping(value = "/exportXls")
   public ModelAndView exportXls(HttpServletRequest request, FinPayableCheckEntry finPayableCheckEntry) {
       return super.exportXls(request, finPayableCheckEntry, FinPayableCheckEntry.class, "fin_payable_check_entry");
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
       return super.importExcel(request, response, FinPayableCheckEntry.class);
   }

}
