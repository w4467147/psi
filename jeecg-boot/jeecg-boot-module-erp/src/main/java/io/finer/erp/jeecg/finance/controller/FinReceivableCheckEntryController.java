package io.finer.erp.jeecg.finance.controller;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import io.finer.erp.jeecg.finance.entity.FinReceivableCheckEntry;
import io.finer.erp.jeecg.finance.service.IFinReceivableCheckEntryService;
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
* @Description: fin_receivable_check_entry
* @Author: jeecg-boot
* @Date:   2020-04-17
* @Version: V1.0
*/
@Api(tags="fin_receivable_check_entry")
@RestController
@RequestMapping("/finance/finReceivableCheckEntry")
@Slf4j
public class FinReceivableCheckEntryController extends JeecgController<FinReceivableCheckEntry, IFinReceivableCheckEntryService> {
   @Autowired
   private IFinReceivableCheckEntryService finReceivableCheckEntryService;
   
   /**
    * 分页列表查询
    *
    * @param finReceivableCheckEntry
    * @param pageNo
    * @param pageSize
    * @param req
    * @return
    */
   @AutoLog(value = "fin_receivable_check_entry-分页列表查询")
   @ApiOperation(value="fin_receivable_check_entry-分页列表查询", notes="fin_receivable_check_entry-分页列表查询")
   @GetMapping(value = "/list")
   public Result<?> queryPageList(FinReceivableCheckEntry finReceivableCheckEntry,
                                  @RequestParam(name="pageNo", defaultValue="1") Integer pageNo,
                                  @RequestParam(name="pageSize", defaultValue="10") Integer pageSize,
                                  HttpServletRequest req) {
       QueryWrapper<FinReceivableCheckEntry> queryWrapper = QueryGenerator.initQueryWrapper(finReceivableCheckEntry, req.getParameterMap());
       Page<FinReceivableCheckEntry> page = new Page<FinReceivableCheckEntry>(pageNo, pageSize);
       IPage<FinReceivableCheckEntry> pageList = finReceivableCheckEntryService.page(page, queryWrapper);
       return Result.ok(pageList);
   }
   
   /**
    *   添加
    *
    * @param finReceivableCheckEntry
    * @return
    */
   @AutoLog(value = "fin_receivable_check_entry-添加")
   @ApiOperation(value="fin_receivable_check_entry-添加", notes="fin_receivable_check_entry-添加")
   @PostMapping(value = "/add")
   public Result<?> add(@RequestBody FinReceivableCheckEntry finReceivableCheckEntry) {
       finReceivableCheckEntryService.save(finReceivableCheckEntry);
       return Result.ok("添加成功！");
   }
   
   /**
    *  编辑
    *
    * @param finReceivableCheckEntry
    * @return
    */
   @AutoLog(value = "fin_receivable_check_entry-编辑")
   @ApiOperation(value="fin_receivable_check_entry-编辑", notes="fin_receivable_check_entry-编辑")
   @PutMapping(value = "/edit")
   public Result<?> edit(@RequestBody FinReceivableCheckEntry finReceivableCheckEntry) {
       finReceivableCheckEntryService.updateById(finReceivableCheckEntry);
       return Result.ok("编辑成功!");
   }
   
   /**
    *   通过id删除
    *
    * @param id
    * @return
    */
   @AutoLog(value = "fin_receivable_check_entry-通过id删除")
   @ApiOperation(value="fin_receivable_check_entry-通过id删除", notes="fin_receivable_check_entry-通过id删除")
   @DeleteMapping(value = "/delete")
   public Result<?> delete(@RequestParam(name="id",required=true) String id) {
       finReceivableCheckEntryService.removeById(id);
       return Result.ok("删除成功!");
   }
   
   /**
    *  批量删除
    *
    * @param ids
    * @return
    */
   @AutoLog(value = "fin_receivable_check_entry-批量删除")
   @ApiOperation(value="fin_receivable_check_entry-批量删除", notes="fin_receivable_check_entry-批量删除")
   @DeleteMapping(value = "/deleteBatch")
   public Result<?> deleteBatch(@RequestParam(name="ids",required=true) String ids) {
       this.finReceivableCheckEntryService.removeByIds(Arrays.asList(ids.split(",")));
       return Result.ok("批量删除成功!");
   }
   
   /**
    * 通过id查询
    *
    * @param id
    * @return
    */
   @AutoLog(value = "fin_receivable_check_entry-通过id查询")
   @ApiOperation(value="fin_receivable_check_entry-通过id查询", notes="fin_receivable_check_entry-通过id查询")
   @GetMapping(value = "/queryById")
   public Result<?> queryById(@RequestParam(name="id",required=true) String id) {
       FinReceivableCheckEntry finReceivableCheckEntry = finReceivableCheckEntryService.getById(id);
       if(finReceivableCheckEntry==null) {
           return Result.error("未找到对应数据");
       }
       return Result.ok(finReceivableCheckEntry);
   }

    /**
   * 导出excel
   *
   * @param request
   * @param finReceivableCheckEntry
   */
   @RequestMapping(value = "/exportXls")
   public ModelAndView exportXls(HttpServletRequest request, FinReceivableCheckEntry finReceivableCheckEntry) {
       return super.exportXls(request, finReceivableCheckEntry, FinReceivableCheckEntry.class, "fin_receivable_check_entry");
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
       return super.importExcel(request, response, FinReceivableCheckEntry.class);
   }

}
