package io.finer.erp.jeecg.bas.controller;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import io.finer.erp.jeecg.bas.entity.BasSequence;
import io.finer.erp.jeecg.bas.service.IBasSequenceService;
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
 * @Description: bas_sequence
 * @Author: jeecg-boot
 * @Date: 2020-03-20
 * @Version: V1.0
 */
@Api(tags = "bas_sequence")
@RestController
@RequestMapping("/bas/basSequence")
@Slf4j
public class BasSequenceController extends JeecgController<BasSequence, IBasSequenceService> {
    @Autowired
    private IBasSequenceService basSequenceService;

    /**
     * 分页列表查询
     *
     * @param basSequence
     * @param pageNo
     * @param pageSize
     * @param req
     * @return
     */
    @AutoLog(value = "bas_sequence-分页列表查询")
    @ApiOperation(value = "bas_sequence-分页列表查询", notes = "bas_sequence-分页列表查询")
    @GetMapping(value = "/list")
    public Result<?> queryPageList(BasSequence basSequence,
                                   @RequestParam(name = "pageNo", defaultValue = "1") Integer pageNo,
                                   @RequestParam(name = "pageSize", defaultValue = "10") Integer pageSize,
                                   HttpServletRequest req) {
        QueryWrapper<BasSequence> queryWrapper = QueryGenerator.initQueryWrapper(basSequence, req.getParameterMap());
        Page<BasSequence> page = new Page<BasSequence>(pageNo, pageSize);
        IPage<BasSequence> pageList = basSequenceService.page(page, queryWrapper);
        return Result.ok(pageList);
    }

    /**
     * 添加
     *
     * @param basSequence
     * @return
     */
    @AutoLog(value = "bas_sequence-添加")
    @ApiOperation(value = "bas_sequence-添加", notes = "bas_sequence-添加")
    @PostMapping(value = "/add")
    public Result<?> add(@RequestBody BasSequence basSequence) {
        basSequenceService.save(basSequence);
        return Result.ok("添加成功！");
    }

    /**
     * 编辑
     *
     * @param basSequence
     * @return
     */
    @AutoLog(value = "bas_sequence-编辑")
    @ApiOperation(value = "bas_sequence-编辑", notes = "bas_sequence-编辑")
    @PutMapping(value = "/edit")
    public Result<?> edit(@RequestBody BasSequence basSequence) {
        basSequenceService.updateById(basSequence);
        return Result.ok("编辑成功!");
    }

    /**
     * 通过id删除
     *
     * @param id
     * @return
     */
    @AutoLog(value = "bas_sequence-通过id删除")
    @ApiOperation(value = "bas_sequence-通过id删除", notes = "bas_sequence-通过id删除")
    @DeleteMapping(value = "/delete")
    public Result<?> delete(@RequestParam(name = "id", required = true) String id) {
        basSequenceService.removeById(id);
        return Result.ok("删除成功!");
    }

    /**
     * 批量删除
     *
     * @param ids
     * @return
     */
    @AutoLog(value = "bas_sequence-批量删除")
    @ApiOperation(value = "bas_sequence-批量删除", notes = "bas_sequence-批量删除")
    @DeleteMapping(value = "/deleteBatch")
    public Result<?> deleteBatch(@RequestParam(name = "ids", required = true) String ids) {
        this.basSequenceService.removeByIds(Arrays.asList(ids.split(",")));
        return Result.ok("批量删除成功!");
    }

    /**
     * 通过id查询
     *
     * @param id
     * @return
     */
    @AutoLog(value = "bas_sequence-通过id查询")
    @ApiOperation(value = "bas_sequence-通过id查询", notes = "bas_sequence-通过id查询")
    @GetMapping(value = "/queryById")
    public Result<?> queryById(@RequestParam(name = "id", required = true) String id) {
        BasSequence basSequence = basSequenceService.getById(id);
        if (basSequence == null) {
            return Result.error("未找到对应数据");
        }
        return Result.ok(basSequence);
    }

    /**
     * 导出excel
     *
     * @param request
     * @param basSequence
     */
    @RequestMapping(value = "/exportXls")
    public ModelAndView exportXls(HttpServletRequest request, BasSequence basSequence) {
        return super.exportXls(request, basSequence, BasSequence.class, "bas_sequence");
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
        return super.importExcel(request, response, BasSequence.class);
    }

}
