// Import and register all your controllers from the importmap under controllers/*

import { application } from "controllers/application"
// import { definitionsFromContext } from "/stimulus/webpack-helpers"

// Eager load all controllers defined in the import map under controllers/**/*_controller
import { eagerLoadControllersFrom } from "@hotwired/stimulus-loading"
eagerLoadControllersFrom("controllers", application)
//import RemoteModalController from "./remote_modal_controller";
//application.register("remote-modal", RemoteModalController);

// Lazy load controllers as they appear in the DOM (remember not to preload controllers in import map!)
// import { lazyLoadControllersFrom } from "@hotwired/stimulus-loading"
// lazyLoadControllersFrom("controllers", application)

// const context = require.context("controllers", true, /_controller\.js$/)
// application.load(definitionsFromContext(context))
