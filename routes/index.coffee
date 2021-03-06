express = require 'express'
fs = require 'fs'
path = require 'path'
render = require '../tools/render'
mdtools = require '../tools/markDown'
updata = require '../tools/updata'
router = express.Router()

# GET home page.
router.get '/', (req, res, next) ->
  buffStr = fs.readFileSync path.join(__dirname, '../doc/readme.md'),'utf8'
  mdtools.toHtml buffStr, (html, menu) ->
    render.index res,
      title: 'Wiki 文档中心'
      html: html
      menu: menu
      tree: req.tree
      map: []
      loginInfo:req.loginInfo
    return
  return

# GET home page.
router.get '/book', (req, res, next) ->
  md = req.query.md
  buffStr = fs.readFileSync path.join(__dirname, '../doc/' + md + '.md'),'utf8'
  mdtools.toHtml buffStr, (html, menu) ->
    render.index res,
      title: md.split('/').pop()
      html: html
      menu: menu
      tree: req.tree
      map: md.split('/')
      loginInfo:req.loginInfo
      download:req.query.md
    return
  return



module.exports = router
